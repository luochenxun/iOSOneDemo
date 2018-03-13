#  Image基础



## iOS中的image是什么？


Image是什么？问到这个问题的时候，相信很多人会有点懵逼，但是其实只要简单地像下面一样输出图片NSData结构，就可以马上明白image是什么

<pre>

UIImage *tempImage = [UIImage imageNamed:@"earth"];
CFDataRef imageData = CGDataProviderCopyData(CGImageGetDataProvider(tempImage.CGImage));

</pre>

输出上面的 imageData，可以得到如下日志：
```
" <0c71a5ff 0c70a5ff 0d71a5ff 0c71a5ff
0c71a5ff 0c71a5ff 0c71a5ff 0c71a5ff 0c71a5ff 0c71a5ff>"
```

其中可以看出，每一段是由2个字节组成，每两位数字刚好表达了 "RGBA"颜色通道中的一个。

所以，image其实本质上就是图片中像素的排列。图片的象素就像是一个矩阵，使用一些数学的方法对之进行变换就是我们说的”渲染“。

### UIImage | CGImage | CIImage 之间的区别

我们知道，iOS里关于图像有三个重要的类 UIImage | CGImage | CIImage ，他们之前有什么关系与区别呢？

其实归结到底，他们只是不同的框架下得产物，同样也正因为不同的框架，使得他们的操作发生了质的变化。

- UIImage : 负责UIKit中的图片展示&数据管理。(CPU计算)
- CGImage: CoreGraphic中对图片的"旋转、缩放 & 挖取"工作。（GPU计算）
- CIImage : 描述一个如何产生一个图像，但其本身本身并不包含图像数据，
它代表的是图像数据或者生成图像数据的流程（如"滤镜的输出"）

###  Core Image 的优势：

最大化利用其所运行之上的硬件的。

每个滤镜实际上的实现，即-"内核"，是由一个GLSL(即 OpenGL 的着色语言) 的子集来书写的.当多个滤镜连接成一个滤镜图表，

Core Image 便把内核串在一起来构建一个可在 GPU 上运行的高效程序，事实上，图像处理和渲染就是将渲染到窗口的像素点进行许多的浮点运算，那么GPU (图形处理器) 可以高效的完成。



## image是怎样绘制到屏幕上的

### imageIO

把图片从硬盘上读取并解码，是 ImageIO的主要工作。

ImageIO对外开放的对象有CGImageSourceRef、CGImageDestinationRef，不对外开放的对象有CGImageMetadataRef。CoreGraphics中经常与imageIO打交道的对象有CGImageRef和CGDataProvider，我们主要要理解这五个对象在创建一个UIImage中担任了哪些角色。


### 从 CFDataRef 到 UIImage

这个过程主要经过如下代码：

<pre>

NSString *resource = [[NSBundle mainBundle] pathForResource:@"xx" ofType:@"png"];
NSData *data = [NSData dataWithContentsOfFile:resource options:0 error:nil];

CFDataRef dataRef = (__bridge CFDataRef)data;

CGImageSourceRef source = CGImageSourceCreateWithData(dataRef, nil);

CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil);

UIImage *image = [UIImage imageWithCGImage:cgImage];

</pre>


硬盘上的图片 -> NSData -> CFDataRef -> CGImageSourceRef -> CGImageRef -> UIImage -> UIImageVIew显示之

从CFDataRef到创建出UIImage，这个过程都不涉及对图像的解码，只是读取了一些图像的基础数据与元数据。

- CGImageRef

在构建  CGImageRef时，主要是读取图片的基础数据与元数据，基础数据中包括Image的header chunk，比如png的IHDR。元数据是由CGImageMetadataRef来抽象的。并且没有读取图片的其他数据，更没有做解码的动作。


### Image 的初始化方法

当调用 imageWithData或 imageWithContentOfFile时，先把图片文件能过 mmap从硬盘直拷到内存，然后再通过CGImageSourceRef访问图像数据，创建CGImageRef。

imageNamed先从Bundle里找到资源路径，然后同样也是将文件mmap到内存，再通过CGImageSourceRef访问图像数据，创建CGImageRef。


### CGImageRef解码

Image解码发生在CGDataProviderCopyData函数内部调用ImageProviderCopyImageBlockSetCallback设置的callback或者copyImageBlock函数，根据不同的图片格式调用的不同的方法中（比如png或jpeg调用的解码方法是不同的）。

![imageIO主要类关系图](./MDImage/image_imageio.png)










