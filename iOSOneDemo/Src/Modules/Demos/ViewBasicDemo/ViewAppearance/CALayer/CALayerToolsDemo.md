
# 各种CALayer专用图层


各种CALayer子类可以满足各种界面绘制的场景。这算是CALayer对外提供的工具类了，用它们可以方便地绘制你想要的图形。

绘图时要注意的点：

1. 一般要设置layer的contentScale = [UIScreen mainScreen].scale;
2. 直接添加，无需手动调用 setNeedDisplay方法；



## CATextLayer

Core Animation提供了一个 CALayer 的子类 CATextLayer ，它以图层的形式包含了 UILabel 几乎所有的绘制特性，并且额外提供了一些新的特性。让你可以方便地制作一个包含你想要文本的图层。

- 什么要使用 CATextLayer？

1. CATextLayer相较UILabel要更轻量级、更快些。CATextLayer使用 Core text渲染，速度上更快；

- 主要参数

<pre>
- string
要输出的字符串，这个是CATextLayer最主要的属性

- font, fontSize, alignmentMode

字体，字体大小，对齐方式

- foregroundColor

字体的颜色

</pre>

示例：

<pre>
CATextLayer *tLayer =[CATextLayer layer];
tLayer.contentsScale = [UIScreen mainScreen].scale; // 注意，这个不能忘
tLayer.string = @"CATextLayer 测试一下";
tLayer.bounds = CGRectMake(0, 0, 300, 20);
tLayer.fontSize = 14.f; //字体的大小
tLayer.font = (__bridge CFTypeRef _Nullable)(@"HelveticaNeue-BoldItalic"); //字体的名字 不是 UIFont
tLayer.alignmentMode = kCAAlignmentCenter; //字体的对齐方式
tLayer.position = CGPointMake(150, 0);
tLayer.foregroundColor =[UIColor redColor].CGColor; //字体的颜色
</pre>


## CAShapeLayer

CAShapeLayer 可以用来绘制所有能够通过 CGPath 来表示的形状。这个形状不一定要闭合，路径也不一定要不可破。

因此，CAShapeLayer经常与UIBezierPath一起使用。UIBezierPath类允许你在自定义的 View 中绘制和渲染由直线和曲线组成的路径.。你可以在初始化的时候直接为你的UIBezierPath指定一个几何图形。
通俗点就是UIBezierPath用来指定绘制图形路径，而CAShapeLayer就是根据路径来绘图的。

使用CAShpageLayer同样有许多优点：

1. 渲染快速。 CAShapeLayer 使用了硬件加速，绘制同一图形会比用Core Graphics快很多。
2. 高效使用内存。一个 CAShapeLayer 不需要像普通 CALayer 一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
3. 不会出现像素化。当你给 CAShapeLayer 做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化。

### 主要参数

<pre>

- path

图层要绘制的路径，这个可以说是最主要的属性了。

- fillColor , strokeColor

描边色与都填充色。

- fillRule

填充规则，'non-zero' or 'even-odd'。

- stokeStart , strokeEnd

绘制描边时的区域，取值为比例位置(like anchorPoint, 0~1，0是开始位置，1为结束位置)

- lineWidth , miterLimit, lineCap , lineJoin, lineDashPhase, lineDashPattern

lineWidth: 线宽
miterLimit: 最大斜接长度(与动画相关)。
lineCap: 线段头样式(kCALineCapButt, kCALineCapRound ,kCALineCapSquare)。
lineJoin: 连接点样式(kCALineJoinMiter、kCALineJoinRound、kCALineJoinBevel),
lineDashPhase: 虚线起始位置。
lineDashPattern：虚线样式模板（数组）。

</pre>

示例

<pre>
// 使用 CAShapeLayer 在黄色区域中画一个矩形（蓝边框、红填充、上方下圆角)

CAShapeLayer *sLayer = [CAShapeLayer layer];
sLayer.contentsScale = [UIScreen mainScreen].scale;
sLayer.frame = CGRectMake(0, 0, 150, 150);
sLayer.backgroundColor = [UIColor yellowColor].CGColor; // 设置 layer背景色
sLayer.strokeColor = [UIColor blueColor].CGColor; // 设置描边色
sLayer.fillColor = [UIColor redColor].CGColor; //设置填充色
sLayer.lineJoin = kCALineJoinRound;
sLayer.lineCap = kCALineCapRound;
sLayer.lineWidth = 4;
UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100)
byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
cornerRadii:CGSizeMake(10, 10)];
sLayer.path = path.CGPath;
</pre>



## CATransformLayer

如果我们像讲 Transform那章一样画了多个立方形，怎么去旋转他们呢？

在那一张，我们是通过转动父layer的sublayerTransform属性来实现的，但是如果是多个立方形，就不能这样的，不然多个立方形会跟着一起转动。

那我们怎么做呢？我们可以创建一个 CATransformLayer，然后把每个立方形放到独立的 CATransformLayer上，当要转动时，直接转动CATransformLayer就行了，他会对其中的子layer一起转动（只需要赋值给其 transform属性），相当于 sublayerTransform。

<pre>
CATransformLayer *cube = [CATransformLayer layer];

[cube addSublayer:face1]; ...

...
cube.transform = transform;
</pre>



## CAGradientLayer

渐变色图层控件，可以很方便地画出渐变色控件。

- 主要参数

<pre>

- colors : array<id CGColor>

传入一个数组，规定所有的渐变色。

- locations : array<NSNumber>

渐变颜色的区间分布（就是colos中每个渐变颜色的起点和最后颜色的终点位置，这里用的是比例位置，参考anchorPoint），locations的数组长度和colors一致。这个属性可不设，默认是nil，系统会平均分布颜色如果有特定需要可设置，数组设置为0 ~ 1之间单调递增。

- startPoint , endPoint

使用与anchorPoint一样的比例坐标，startPoint默认(0.5, 0)， endPoint默认(0.5,1)，也就是从顶边的中点，到底边的中点，从上到下渐变。

- type

绘制类型，默认 ***kCAGradientLayerAxial***（表示按像素均匀变化）。

</pre>


- 示例

<pre>
// CAGradientLayer
CAGradientLayer *gLayer = [CAGradientLayer new];
gLayer.contentsScale = [UIScreen mainScreen].scale;
gLayer.frame = CGRectMake(0, 0, 100, 100);
gLayer.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
gLayer.type = kCAGradientLayerAxial;
gLayer.locations = @[@0.0f, @1.0f];
layerFrame = [UIView new];
[layerFrame.layer addSublayer:gLayer];
layerFrame.flexSize = CGSizeMake(100, 100);
</pre>
