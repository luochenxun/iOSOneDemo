#  绘图画布 GraphicsContext



## GraphicsContext基本概念

图象上下文 -- 我称之为绘图画布。


### 画布

想像下你想自己绘制自定义的View，那你是怎么样把View“画”在屏幕上呢？

iOS会提供一块画布给你，也就是 GraphicsContext，然后你再使用各种方法将自己想要画的图形“画”在画布上。

同时，iOS也提供了许多方便的工具：
- 比如 UIKit，让你可以把一些基本元素：UIImage, NSString, UIBezierPath等画在画布上；
- 还有 CoreGraphics，提供了方便的方法让你在画布上画出直线，圆等图形。


### current graphics context

我们说GraphicsContext是画布，其实具体来说：

<pre>

A graphics context is the place where information about the drawing state is stored. This includes fill color, stroke color, line width, line pattern, winding rule, mask, current path, transparency layers, transform, text transform, etc.

</pre>

GraphicsContext是一个存储了各种绘画信息的对象。当你绘画时，就使用了这样一个绘画信息对象。而 current contexts就是当前用于绘画的一个.


## 获取画布

一般有两种基本方法获取画布绘制UI：

1. 创建一个 image context
2. 继承UIView，重载 drawRect or drawLayer 方法

### 创建一个image context

通过 ***UIGraphicsBeginImageContext*** 方法创建一个image画布，此时会提供了个 image context作为 GraphicsContext画布，同时还会将之设置为 current context。我们会在后面 image context中介绍实现代码。

### 继承UIView，重载 drawRect or drawLayer 方法

drawRect方法的 graphics context 就是 current context，直接画就行。

drawLayer: 方法会传入一个 context，这个context并不是current context，如果要使用UIKit画的话还要将之入栈，成为一个 current context.


### 使用UIKit 方法

使用UIKit的方法必须是用 current context画才行。

<pre>

@interface GCDemoCustomView : UIView

@end

@implementation GCDemoCustomView

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor redColor] setFill];  // 相当于设置了画笔的颜色。
    [p fill];
}

@end

</pre>


### 使用CoreGraphics 方法

CoreGraphics 方法，即Quartz 2D，是iOS中二维绘图引擎, 同时支持iOS和Mac OS X系统(跨平台,纯C语言的),包含在Core Graphics框架中.

Quartz2D的API是纯C语言的，它是一个二维绘图引擎，同时支持iOS和Mac系统。

Quartz2D的API来自于Core Graphics框架，数据类型和函数基本都以CG作为前缀。通常，我们可以使用系统提供的控件去完成大部分UI，但是有些UI界面极其复杂、而且比较个性化，用普通的UI控件无法实现，这时可以利用Quartz2D技术将控件内部的结构画出来，类似自定义控件。其实，iOS中大部分控件的内容都是通过Quartz2D画出来的，因此，Quartz2D在iOS开发中很重要的一个价值是：自定义view（自定义UI控件）。

<pre>

@interface GCDemoCustomView2 : UIView

@end

@implementation GCDemoCustomView2

- (void)drawRect:(CGRect)rect
{
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(con, CGRectMake(0, 0, 100, 100));
    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);
    CGContextFillPath(con);
}

@end

</pre>


### 在 drawLayer中

因为使用UIKit的方法必须是用 current context画才行。所以使用UIKit的话得把当前要使用的context句柄压入current context栈！画完再出栈

- UIKit

<pre>

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    UIGraphicsPushContext(ctx);
    UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor yellowColor] setFill];
    [p fill];
    UIGraphicsPopContext();
}

</pre>



- CoreGraphics

和在drawRect一样，只不过这次直接使用传入的 contextRef即可。




##  image context

上面说过， ***UIGraphicsBeginImageContext*** 方法创建一个image画布，此时会提供了个 image context作为 GraphicsContext画布，同时还会将之设置为 current context。

<pre>

// create image context and generate img
UIGraphicsBeginImageContext(CGSizeMake(100, 100));
UIBezierPath *p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(150, 0, 100, 100)];
[[UIColor yellowColor] setFill];
[p fill];
UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

// show the image use a imageview
UIImageView *iv = [[UIImageView alloc] initWithImage:image];
[iv setFlexSize:CGSizeMake(100, 100)];
[imgContextBox flex_addSubview:iv];


使用 CoreGraphics 是也是一样的，就不赘述了。

</pre>


可以看出输出到image上如果没有画的部分是透明的。 上面画上View上也一样，之所以是黑色是因为View如果没有绘东西是黑色的底。而这里使用imageView装载此image，默认是白色的底。


可以直接使用 UIImage 的 drawInRect 功能绘制图片输出到image上。当两张图片重合时，可以设置他们的 blendMode。我在示例中罗列了各种 blendMode

<pre>

image = [UIImage imageNamed:@"earth"];
UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 2, image.size.height * 2));
[image drawInRect:CGRectMake(0, 0, image.size.width * 2, image.size.height * 2)];
[image drawInRect:CGRectMake(image.size.width/2, image.size.height/2, image.size.width, image.size.height)
blendMode:kCGBlendModeDarken alpha:1.0];
image = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

</pre>






















