#  绘制Image、CGImage




## CGImage


与 UIImage 对应的 CoreGraphices 版本就是 CGImage(实际上是 CGImageRef)。

### 关键点

1. UIImage 与 CGImage互相转换；
2. 图片翻转问题
3. 图片分辨率问题
4. 图片截取
5. CGImageRelease 释放问题

### 互相转换

<pre>

UIImage -> CGImage
   img.CGImage （UIImage有一个CGImage属性直接转之）

CGImage -> UIImage
    [UIImage imageWithCGImage:] （反之要使用UIImage的初始化方法）

</pre>


### 问题1 图片翻转问题

像这样直接绘制CGImage会出现图片翻转问题。

<pre>

    UIImage *img = [UIImage imageNamed:@"earth"];
    CGSize size = img.size;
    CGImageRef cgImg = [img CGImage];
    UIGraphicsBeginImageContext(size);
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), cgImg);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImg);

</pre>


这是因为 Core Graphics是源自 OS X世界的库，也就是源于PC系统。在桌面系统中，坐标原点是在左下角的，而iOS坐标原点是在左上角，这就导致图片看起来是上下映象翻转了。

![图片翻转问题](./MDImage/drawing_cgimage.png)

从上面的示例可以看出因为坐标系统的不同，导致了三角形上下翻转过来了。


- 解决方法1 - 绘制两遍使之翻转再翻转（转两次相当于转回正常）

封装成flip函数

<pre>

CGImageRef flip(CGImageRef im)
{
    CGSize size = CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    UIGraphicsBeginImageContext(size);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height), im);
    CGImageRef resultImageRef = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    return resultImageRef;
}

</pre>

在绘制时使用flip翻转之

<pre>

CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height), flip(cgImg));

</pre>


- 解决方法2 - 不使用CGImage绘制，转成UIImage再绘制

<pre>

UIImage *img = [UIImage imageNamed:@"earth"];
CGImageRef cgImg = [img CGImage];
UIGraphicsBeginImageContext(size);
img = [UIImage imageWithCGImage:cgImg scale:img.scale orientation:UIImageOrientationUp];
[img drawAtPoint:CGPointMake(0, 0)];
img = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();
CGImageRelease(cgImg);

</pre>


- 解决方法3 - 使用 transform翻转

此法最推荐，因为不用输出多份image，比较节省内存



<pre>

imageView.transform = CGAffineTransformMakeScale(1.0,-1.0);

</pre>


###  图片分辨率问题

CGImage是没有 scale信息的，所以，CGImage图片的长宽单位应该是象素。如果没有注意这点的话，很可能输出的图片只有原图的一部分。看看下面的代码及Log输出：

<pre>

img = [UIImage imageNamed:@"earth"];
size = img.size;
CGImageRef testCgImg = [img CGImage];
CGSize testCgSize = CGSizeMake(CGImageGetWidth(testCgImg), CGImageGetHeight(testCgImg));
NSLog(@"UIImage's size in 2x: %@", NSStringFromCGSize(size)); // {150, 150}
NSLog(@"CGImage's size in 2x: %@", NSStringFromCGSize(testCgSize)); // {300, 300}

</pre>


在2x屏幕下，CGImage的大小较UIImage大，因为两者的单位是不同的。所以对CGImage处理时要把Scale计算在内。


### 图片截取

<pre>

UIImage *img = [UIImage imageNamed:@"earth"];
CGSize size = img.size;
CGFloat scale = img.scale;  // 解决分辨率问题
// 注意这里截取时使用了Scale! 也可以使用CGImage的大小Size去截取，如：
// CGSize cgImgSize = CGSizeMake(CGImageGetWidth(cgImg), CGImageGetHeight(cgImg));
CGImageRef leftImg = CGImageCreateWithImageInRect([img CGImage], CGRectMake(0, 0, size.width * scale /2, size.height * scale));
CGImageRef rightImg = CGImageCreateWithImageInRect([img CGImage], CGRectMake(size.width * scale /2, 0, size.width  * scale /2, size.height * scale));
UIGraphicsBeginImageContext(CGSizeMake(size.width * 1.5, size.height));
con = UIGraphicsGetCurrentContext();
// 截取时要使用scale,输出时不需要
CGContextDrawImage(con, CGRectMake(0, 0, size.width/2, size.height), flip(leftImg));
CGContextDrawImage(con, CGRectMake(size.width, 0, size.width/2, size.height), flip(rightImg));
img = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();
CGImageRelease(leftImg);  // 注意下小节说的CGImage释放问题
CGImageRelease(rightImg);

</pre>


### CGImageRelease 释放问题

在ARC中CGImage的引用释放也是自动的，一般不需要手动使用CGImageRelease释放之。
但是在使用像 CGImageCreateWithImageInRect 这类CG方法时，因为在库中创建了引用并不会自动释放，所以需要手动地调用 CGImageCreateWithImageInRect。

规则就是只有当CGImageRef使用creat或retain种全名方式的库方法才要手动release，否则对于自动释放的CGImageRef使用CGImageRelease会造成Crash。





## Snapshot

### 法一，使用 CALayer的 renderInContext:context 方法

效率不太高

<pre>

UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
CGRect rect = [keyWindow bounds];
UIGraphicsBeginImageContext(rect.size);
CGContextRef context = UIGraphicsGetCurrentContext();
[keyWindow.layer renderInContext:context];
UIImage *screenImg = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

</pre>

### 法二： UIView的drawViewHierarchyInRect:

比方法1要快很多


### 法三：UIView的snapshotViewAfterScreenUpdates

UIView的snapshotViewAfterScreenUpdates 返回一个View，这个View包含有一张图片就是当前屏幕的截图。

还有resizableSnapshotViewFromRect: 方法，返回一个可以设置缩放属性的View

<pre>

UIView *snapView = [self.outerBox snapshotViewAfterScreenUpdates:NO];
snapView.frame = snapViewFrame.bounds;
snapView.contentMode = UIViewContentModeScaleAspectFit;

</pre>










