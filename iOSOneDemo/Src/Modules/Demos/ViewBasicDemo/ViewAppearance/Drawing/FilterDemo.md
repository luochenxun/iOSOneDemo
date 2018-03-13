#  滤镜 - CIFilter & CIImage


## 总述

CIFilter & CIImage 中的 CI，Core Image之意，此库包含的都是使用数学算法对图象进行处理的工具。


### 基础类

- Core Image（CIImage）:
输入(可通过UIImage、图像文件和像素数据创建) && 输出图像数据(filter.outputImage方法获得)。

- CIFilter:
应用的滤镜，通过键-值对 决定操作参数(可通过"[filter attributes]"查看参数的取值范围以及说明)。

- CIContext:
表明上下文，通过CIContext绘制及渲染的CIImage图片数据，才会绘制成APP可以使用的图片。


### 滤镜的工作原理与分类

滤镜是一个个对图像处理的算法的封装，使得对图象的处理就像是一套工厂流水线一样，原始图象经过一个个过滤器，最终得到最后处理的结果。

![滤镜处理示意图](./MDImage/drawing_filter.png)

只有在最后输出图片时才会进行真正的图片处理。注意，Core Image的处理是在GPU里进行的！后面有对GPU处理及CPU处理进行进一步的讨论。

所以，我们现在可以把CIFilter理解为一个图片处理算法对象的封装，他的各种输入参数包括输入图片都是以键值对形式配置的，如下：



## 怎么使用滤镜

1. UIImage -> CIImage
2. build CIFilter Chain
3. CIContext -> last filter.outputImage -> CGImageRef
4. CGImage -> UIIMage ， 或者 CIImage直接 -> UIImage（自动创建CIContext）

### 首先要将UIImage转换成CIImage

<pre>

UIImage *sourceImg = [UIImage imageNamed:@"rain"];
CIImage *ciImg = [[CIImage alloc] initWithCGImage:sourceImg.CGImage];

</pre>


### 构建 Filter Chain

<pre>

// filter1
CIFilter *filter1 = [CIFilter filterWithName:@"CIRadialGradient"];
CIVector *center = [CIVector vectorWithX:imgExtent.size.width/2 Y:imgExtent.size.height/2];
[filter1 setValue:center forKey:@"inputCenter"];
[filter1 setValue:@50 forKey:@"inputRadius0"];
[filter1 setValue:@100 forKey:@"inputRadius1"];
CIImage *filter1Output = [filter1 valueForKey: @"outputImage"];

// filter2
CIFilter *filter2 = [CIFilter filterWithName:@"CIBlendWithMask"];
[filter2 setValue:ciImg forKey:kCIInputImageKey];
[filter2 setValue:filter1Output forKey:@"inputMaskImage"];

</pre>


### 输出Image

这里列出两种输出方式，也可以 CIImage直接 -> UIImage

<pre>

// 输出 bitmap
CIContext *ciContext = [CIContext contextWithOptions:nil];
CGImageRef outputCGImg = [ciContext createCGImage:filter2.outputImage fromRect:imgExtent];
UIImage *outputImg = [UIImage imageWithCGImage:outputCGImg];
CGImageRelease(outputCGImg);

// 也可以这样输出
//    UIGraphicsBeginImageContextWithOptions(moiextent.size, NO, 0);
//    [[UIImage imageWithCIImage:filter2] drawInRect:imgExtent];
//    UIImage* outputImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

</pre>


## 自定义滤镜

自定义滤镜，如下封装了filter-chain

<pre>

@interface FilterDemoFilter : CIFilter

@property (nonatomic, strong) CIImage *inputImage;

@end

@implementation FilterDemoFilter

- (CIImage *)outputImage
{
    CGRect inextent = self.inputImage.extent;
    CIFilter *grad = [CIFilter filterWithName:@"CIRadialGradient"];
    CIVector *center = [CIVector vectorWithX:inextent.size.width/2.0 Y:inextent.size.height/2.0];
    [grad setValue:center forKey:@"inputCenter"];
    [grad setValue:@85 forKey:@"inputRadius0"];
    [grad setValue:@100 forKey:@"inputRadius1"];
    CIImage *gradimage = [grad valueForKey: @"outputImage"];

    CIFilter *blend = [CIFilter filterWithName:@"CIBlendWithMask"];
    [blend setValue:self.inputImage forKey:@"inputImage"];
    [blend setValue:gradimage forKey:@"inputMaskImage"];

    return blend.outputImage;
}

@end

</pre>

使用自定义Filter

<pre>

sourceImg = [UIImage imageNamed:@"earth"];
CIImage *ciImg = [[CIImage alloc] initWithCGImage:sourceImg.CGImage];

// 自定义Filter
FilterDemoFilter *customFilter = [FilterDemoFilter new];
[customFilter setValue:ciImg forKey:kCIInputImageKey];

// 输出 bitmap
// 复用示例1中的 context
CGImageRef outputCGImg = [ciContext createCGImage:customFilter.outputImage fromRect:imgExtent];
UIImage *outputImg = [UIImage imageWithCGImage:outputCGImg];
CGImageRelease(outputCGImg);

</pre>


## 优化点 - 更进一步


### 维护全局CIContext以提升性能

在创建结果 UIImage 的时候，最简单的方式就是通过 imageWithCIImage 来实现。这种情况下，不需要显示的声明CIContext，因为 imageWithCIImage 内部自动完成了这个步骤。这使得使用 Core Image 更加的方便。

- CIContext的问题

但是，上面说到的CIContext也引起了另外一个问题，每次都会重新创建一个 CIContext，而 CIContext 的代价是非常高的。
并且，CIContext 和 CIImage 对象是不可变的，在线程之间共享这些对象是安全的。所以多个线程可以使用同一个 GPU 或者 CPU CIContext 对象来渲染 CIImage 对象。
所以重用 CIContext 是很有必要的。这意味着，我们不应该使用 imageWithCIImage 来生成 UIImage，而应该自己创建维护 CIContext。

- 建议频繁操作CIContext。可以建一个全局的变量去维护。（每个上下文中都是有缓存的，频繁创建就用不到 上下文中 的缓存，既浪费资源又浪费内存的消耗）


### 使用CPU渲染和使用GPU渲染

- GPU渲染的优点与缺点

基于 GPU 的话，处理速度更快，因为利用了 GPU 硬件的并行优势。可以使用 OpenGLES 或者 Metal 来渲染图像，这种方式CPU完全没有负担，应用程序的运行循环不会受到图像渲染的影响。

但是 GPU 受限于硬件纹理尺寸，而且如果你的程序在后台继续处理和保存图片的话，那么需要使用 CPU，因为当 App 切换到后台状态时 GPU 处理会被打断。

- CPU渲染的优点与缺点

使用 CPU 渲染的 iOS 会采用 GCD 来对图像进行渲染，这保证了 CPU 渲染在大部分情况下更可靠，比 GPU 渲染更容易使用，可以在后台实现渲染过程。

- 总结

综上，对于复杂的图像滤镜使用 GPU 更好，但是如果在处理视频并保存文件，或保存照片到照片库中时，为避免程序进入后台对图片保存造成影响，这时应该使用 CPU 进行渲染。


## 示例

### 示例1

<pre>

UIImage *sourceImg = [UIImage imageNamed:@"earth"];
CIImage *ciImg = [[CIImage alloc] initWithCGImage:sourceImg.CGImage];
CGRect imgExtent = ciImg.extent;

// filter1
CIFilter *filter1 = [CIFilter filterWithName:@"CIRadialGradient"];
CIVector *center = [CIVector vectorWithX:imgExtent.size.width/2 Y:imgExtent.size.height/2];
[filter1 setValue:center forKey:@"inputCenter"];
[filter1 setValue:@50 forKey:@"inputRadius0"];
[filter1 setValue:@100 forKey:@"inputRadius1"];
CIImage *filter1Output = [filter1 valueForKey: @"outputImage"];

// filter2
CIFilter *filter2 = [CIFilter filterWithName:@"CIBlendWithMask"];
[filter2 setValue:ciImg forKey:kCIInputImageKey];
[filter2 setValue:filter1Output forKey:@"inputMaskImage"];

// 输出 bitmap
CIContext *ciContext = [CIContext contextWithOptions:nil];
CGImageRef outputCGImg = [ciContext createCGImage:filter2.outputImage fromRect:imgExtent];
UIImage *outputImg = [UIImage imageWithCGImage:outputCGImg];
CGImageRelease(outputCGImg);
//   也可以这样输出
//    UIGraphicsBeginImageContextWithOptions(moiextent.size, NO, 0);
//    [[UIImage imageWithCIImage:filter2] drawInRect:imgExtent];
//    UIImage* outputImg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

</pre>

















