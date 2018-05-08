#  CALayer基础

本章将介绍iOS UI编程的一个重要角色 CALayer，它是UIView即iOS各种控件之所以能显示在界面上的基础，负责把View绘制出来。

首先我将介绍什么是CALayer，它和UIView的关系是什么；接着介绍CALayer是怎样输出图像显示在屏幕上的；

作为CALayer基础本章不会说太多具体内容，对于CALayer，我们仍然会以“绘图、布局、动画”几个维度进行详细的介绍。

CALayer就是界面的图层，像是屏幕中叠加起来的多张画，它有许多方便的属性，通过设置这些属性，可以设置画的透明度、边框、阴影，对图层进行拉伸、几何变型；你可以管理多张这样的图层，对它们进行布局定位、排列、层级管理；还可以定义动画，来实现炫酷的效果与交互。

本章会详细介绍下CALayer的概念，介绍下它的绘图与布局，后续章节将介绍它的边框、阴影等特效属性，几何变型，几种专用的图层工具。


## 什么是CALayer，它与UIView是什么关系

要知道什么是CALayer，必须先搞清楚CALayer与UIView的关系（下面说到UIView与CALayer时，也会简写成view与layer）。


### CALayer与UIView的关系

在看下面UIView与CALayer关系时，我们可以先作个比喻，**UIView是一幅PS画出的画，而实际上这幅画是由多个图层叠加而成的，这其中的1个或多个图层我们称之为 layer**。

从这个比喻可以看出：
1. view就像是一个像框，其实不是具体的一个绘制图层，更像是多张图层的载体，将它们层叠之后的结果展示，提供一个可视空间；
2. 一个View起码得有一个layer（UIView确实init时就自动创建一个内置的layer）。
3. UIView之所以能绘制到屏幕，靠的就是CALayer。UIView与CALayer实际上是共用同一个graphics context, view使用layer绘制图象到屏幕上，layer会将绘制的结果缓存(cache)之（在创建UIView对象时，UIView内部会自动创建一个层(即CALayer对象)，通过UIView的layer属性可以访问这个层。当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的层上，绘图完毕后，系统会将层拷贝到屏幕上，于是就完成了UIView的显示）；
4. UIView是CALayer的载体或容器，给 layer提供了可视空间。view必关联一个或多个layer(至少一个)，我们可以通过UIView的layer属性获得关联layer；反之，也可以通过CALayer的delegate属性获取容纳它的UIView。
5. UIView的层级关系决定Layer的层级(layer层次是view层次的子集，也就是view层次改变会改变layer层次，但是layer层次改变不会改变view层次，想下多本相簿与相片的关系)。
6. 相较于Layer，UIView多了事件处理功能。也就是说 layer不能处理用户的触摸事件，但是UIView可以。

### 从代码上看CALayer与UIView之间的关系

1. 我们可以通过UIView的layer属性获得关联layer，也可以通过view的 ***+(Class) layerCalss*** 方法设置view所关联的具体layer。layer也可以通过其delegate方法获得关联的view。
2. view是通过layer绘图的，比如你设置view的 backgroundColor，实际上是设置layer的backgroundColor；
3. view是layer的容器，view的frame就是layer的frame，view决定了layer的可视空间；
4. view使用layer绘制图象到屏幕上，layer会将绘制的结果缓存(cache)之。比如，当view的bounds改变，实际上不需要对view进行重绘，而是拉伸其layer的cached image。


### 为什么使用CALayer，它有什么特性

1. CALayer提供了许多与绘图相关的属性(property，比如加阴影、图角、添加边框等)，可以方便地改变View的形态。
2. CALayer可以通过叠加组合出更多形态与方便管理view的绘制。
2. CALayer的CA，是Core Animation，它是动画的基础。

也就是说 layer也可以通过 ***addSublayer*** 添加图层与使用相关方法管理layer层级。


### CALayer的主要属性与方法

<pre>

--------------- 绘图与显示 -------------

• 内容(比如设置为图片CGImageRef)
@property (retain) id contents;

- contentsGravity  layer上图片的拉伸方式
- contentsScale   layer显示的拉伸比例
- contentsRect    指定layer上显示图片的部分
- contentsCenter  控制layer可拉伸的范围

--------------- 布局与定位 --------------
• 宽度和高度
@propertyCGRect bounds;

• 位置(默认指中点，具体由anchorPoint决定)
@property CGPoint position;

• 锚点(x,y的范围都是0-1)，决定了position的含义
@property CGPoint anchorPoint;


--------------- 显示与特效 --------------

• 背景颜色(CGColorRef类型)
@property CGColorRef backgroundColor;

• 边框颜色(CGColorRef类型)
@property CGColorRef borderColor;

• 边框宽度
@property CGFloat borderWidth;

• 圆角半径
@property CGFloat cornerRadius;

- shadowColor 阴影颜色
- shadowOpacity 阴影透明度
- shadowRadius 阴影半径
- shadowOffset 阴影的位移
- shadowPath 阴影形状（比如圆形的阴影）

--------------- 几何变形 --------------

• 形变属性
@property CATransform3D transform;

</pre>


## CALayer是怎样显示的

CALayer绘图显示在屏幕上有两种主要方式：
- 一种是直接在图层上显示已准备好的图片；
- 一种是自己在Layer上绘图；


### contents属性-在layer上显示图片

CALayer有一个属性***contents***，通过给此属性赋值一个CGImage，可以在图层上显示你赋予的图片。

layer的显示主要是靠content，此属性定义为id，其实是需要一个 CGImage。

- 为什么content类型为id呢

因为在这个库在早期Mac OS时代就已有之，那时可以显示 CGImage与NSImage，在iOS设备上，NSImage已不使用了，所以只剩下赋之以CGImage。我们要真正赋值的其实是一个CGImageRef，一个指向CGImage的指针，但是如果你要赋值，还需要一个转换：

<pre>
layer.contents = (__bridge id)image.CGImage;
</pre>

- 示例 - 在layer上绘制一张图片

<pre>
CALayer *contentLayer = [CALayer new];
UIImage *image = [UIImage imageNamed:@"earth"];
contentLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
contentLayer.contents = (__bridge id)image.CGImage; // 注意，这里要使用CGImage
[layerFrame.layer addSublayer:contentLayer];
</pre>


### 与 contents 相关的其它属性

- contentsGravity  layer上图片的拉伸方式
- contentsScale   layer显示的拉伸比例
- contentsRect    指定layer上显示图片的部分
- contentsCenter  控制layer可拉伸的范围

与UIView、UIImageView一样，只要涉及设置图片的控件，一般都提供了属性设置他们的拉伸方式，CALayer中的拉伸方式叫 contentGravity（其实和contentMode如出一徹，真不知苹果搞这么多定义出来干嘛~）。

<pre>
kCAGravityCenter
kCAGravityTop
kCAGravityBottom
kCAGravityLeft
kCAGravityRight
kCAGravityTopLeft
kCAGravityTopRight
kCAGravityBottomLeft
kCAGravityBottomRight
kCAGravityResize
kCAGravityResizeAspect
kCAGravityResizeAspectFill
</pre>

***contentsScale*** : 在示例中，我们可以看出当使用kCAGravityCenter显示时，如果没有设置***contentsScale***, 发现图片没有按照缩放比渲染到layer上，子layer的contentsScale默认是1(但是如果是view直接包含的layer的话，会自动设置它的scale为当前屏幕的scale). 这个属性还比较重要，它建立了实际绘图与在屏幕上显示的映射比例。对于view自带的或直接关系的layer来说，系统会自动根据屏幕分辨率设置正确的比例。但是对于自己管理的自定义layer，这个值是1，需要手动地去管理。

***contentsRect*** : 这个属性适合用于使用拼接图，也就是把几个图片拼接成一张图片的方法，使用 contentsRect去获取本layer要使用的图片。

***contentsCenter***  : 是一个 CGRect，就像 image的 resizable一样，控制layer可拉伸的范围。如图：
![示例图片](./MDImage/layer-contentsCenter.png)


### 4种绘制方法

CALayer提供了生命周期的绘图回调方法，只要你实现了这些方法，在 ***[layer setNeedsDisplay]*** 调用后会自动调用这些方法来绘制自己。

这里使用 layer 绘图显示要注意，无论是 display还是drawInContext，CALayer是不会主动去调用这些绘图回调去展示的，要显示时，需要手动调用 ***[layer setNeedsDisplay]*** 。

但是UIView初次展示时，系统会自动调用***setNeedsDisplay***，而且会传递给view自带的layer，所以view自带的layer无需要调用此方法也可以展示。

- display

在display方法中，无法获得current graphics context，所以绘图的自由度一定程序会有限制。主要是用各种方法输出image后，通过设置contents的方式绘制layer。

<pre>

// 自定义 Layer
@implementation CALayerBasicDemoCustomLayer

- (void)display
{
    // 使用绘图或其它方法得到 image，再利用设置 contents输出图象
    UIImage *image = [UIImage imageNamed:@"earth"];
    self.contents = (id)image.CGImage;
}

@end

// 将自定义Layer添加入view中显示
CALayerBasicDemoCustomLayer *customLayer = [CALayerBasicDemoCustomLayer new];
customLayer.frame = CGRectMake(0, 0, 100, 100);
[customLayer setNeedsDisplay]; // 重要！
layerFrame = [UIView new];
[layerFrame.layer addSublayer:customLayer];

</pre>

- displayLayer

如果没有实现display()方法，或者调用了super.display()，并且设置了layer的delegate，那么iOS系统会调用delegate的displayLayer() （本质上就是调用其所直属的UIView的 displayLayer方法）。

- drawInContext

如果没有设置delegate，或者delegate没有实现displayLayer()方法，那么接下来会调用layer的drawInContext方法

<pre>

// 自定义 Layer
@implementation CALayerBasicDemoCustomLayer2

- (void)drawInContext:(CGContextRef)context
{
    CGContextAddArc(context, 20, 20, 10, 0, 2 * M_PI, 1); // 画圆
    CGContextSetLineWidth(context, 3); // 设置线粗
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 画线的颜色
    CGContextStrokePath(context); // 画线
}

@end

// 将自定义Layer添加入view中显示
CALayerBasicDemoCustomLayer *customLayer = [CALayerBasicDemoCustomLayer new];
customLayer.frame = CGRectMake(0, 0, 100, 100);
[customLayer setNeedsDisplay]; // 重要！
layerFrame = [UIView new];
[layerFrame.layer addSublayer:customLayer];

</pre>

- drawLayerInContext

如果layer没有实现drawInContext方法，那么接下来就会调用delegate的drawLayerInContext方法

### 绘制时机

1. 改变 bounds一般不会触发重绘

如果需要改变 bounds时重绘，可以设置 ***needsDisplayOnBoundsChange*** 属性。就像设置UIVIew的contentMode为***UIViewContentModeRedraw***一样。

一般改变layer大小是不重绘的，可以想象，无论是通过设置contents方法还是自己在layer上绘图，都会生成一个像素位图的后备存储，我们也可以称之为layer的图象缓存，当layer大小改变时，我们不需要重新渲染去画一遍，只要把这个图象缓存拉伸就行了。

2. Layer不会主动重绘

这个上面解释过了，无论是 display还是drawInContext，CALayer是不会主动去调用这些绘图回调去展示的，要显示时，需要手动调用 ***[layer setNeedsDisplay]*** 。但是UIView初次展示时，系统会自动调用***setNeedsDisplay***，而且会传递给view自带的layer，所以view自带的layer无需要调用此方法也可以展示。

3. 绘制的实现

当UIView需要显示时，它内部的层会准备好一个CGContextRef(图形上下文)，然后调用delegate(这里就是UIView)的drawLayer:inContext:方法，并且传入已经准备好的CGContextRef对象。而UIView在drawLayer:inContext:方法中又会调用自己的drawRect:方法。平时在drawRect:中通过UIGraphicsGetCurrentContext()获取的就是由层传入的CGContextRef对象，在drawRect:中完成的所有绘图都会填入层的CGContextRef中，然后被拷贝至屏幕。

### 绘制过程总结与绘制回调优先级

所以，一般来说，可以在layer的display()或者drawInContext()方法中来绘制
在display()中绘制的话，可以直接给contents属性赋值一个CGImage，在drawInContext()里就是各种调用CoreGraphics的API 。

假如绘制的逻辑特别复杂，希望能从layer中剥离出来，那么可以给layer设置delegate，把相关的绘制代码写在delegate的displayLayer()和drawLayerInContext()方法。

- 绘调优先级

主要是要明确下这些回调起作用的时间点。

contents 在设置时候马上就生效了。所以就算在draw回调里画了画，但是在设置contents时马上会覆盖掉。

同样，就算你调了contents，如果在之后调用setNeedsDisplay，也会重绘覆盖当前图象。


## CALayer的布局与定位

- position和anchorPoint

layer的定位主要靠 position 与 anchorPoint 两个属性


position是本layer在父层layer坐标系中的位置，但是是本layer中那个点在父层layer的position呢？

这个本layer上的点由 anchorPoint 来定。

anchorPoint的x、y取值范围都是0~1，默认值为（0.5, 0.5），表示在相应坐标轴（自身layer的坐标系）上的比例。
比如，（0.5, 0.5），表示在 x轴的0.5倍上，y轴的0.5倍上，所以这个anchor表示本layer的中点；(0,0)表示本layer的左上点，(1,1)表示右下点。

示例 - layer定位的代码

<pre>

// 把红色的 layer1 放在外层 layer的中间
CALayer *layer1 = [CALayer new];
layer1.bounds = CGRectMake(0, 0, 70, 50);
layer1.position = CGPointMake(100, 100); // 设置定位在外层layer的中点
layer1.anchorPoint = CGPointMake(0.5, 0.5); // 设置锚点在本layer的中间
layer1.backgroundColor = [UIColor redColor].CGColor;
[view1.layer addSublayer:layer1];

// 把蓝色的 layer2 放在外层 layer的左上角
CALayer *layer2 = [CALayer new];
layer2.bounds = CGRectMake(0, 0, 30, 20);
layer2.position = CGPointMake(0, 0); // 设置定位在外层layer的左上角
layer2.anchorPoint = CGPointMake(0, 0); // 设置锚点在layer的左上角
layer2.backgroundColor = [UIColor blueColor].CGColor;
[view1.layer addSublayer:layer2];

</pre>





## 各种CALayer子类


各种CALayer子类可以满足各种界面绘制的场景。这算是CALayer对外提供的工具类了，用它们可以方便地绘制你想要的图形。

绘图时要注意的点：

1. 一般要设置layer的contentScale = [UIScreen mainScreen].scale;



### CAScrollLayer

### CATextLayer

Core Animation提供了一个 CALayer 的子类 CATextLayer ，它以图层的形式包含了 UILabel 几乎所有的绘制特性，并且额外提供了一些新的特性。

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
tLayer.string = @"CATextLayer 测试一下";
tLayer.bounds = CGRectMake(0, 0, 300, 20);
tLayer.fontSize = 14.f; //字体的大小
tLayer.font = (__bridge CFTypeRef _Nullable)(@"HelveticaNeue-BoldItalic"); //字体的名字 不是 UIFont
tLayer.alignmentMode = kCAAlignmentCenter; //字体的对齐方式
tLayer.position = CGPointMake(150, 0);
tLayer.foregroundColor =[UIColor redColor].CGColor; //字体的颜色
</pre>


### CAShapeLayer

CAShapeLayer是在坐标系内绘制贝塞尔曲线的，通过绘制贝塞尔曲线，设置shape(形状)的path(路径)，从而绘制各种各样的图形以及不规则图形。

因此，CAShapeLayer经常与UIBezierPath一起使用。UIBezierPath类允许你在自定义的 View 中绘制和渲染由直线和曲线组成的路径.。你可以在初始化的时候直接为你的UIBezierPath指定一个几何图形。
通俗点就是UIBezierPath用来指定绘制图形路径，而CAShapeLayer就是根据路径来绘图的。

- 主要参数

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
CAShapeLayer *sLayer = [CAShapeLayer layer];
sLayer.frame = CGRectMake(0, 0, 150, 150);
sLayer.contentsScale = [UIScreen mainScreen].scale;
sLayer.backgroundColor = [UIColor yellowColor].CGColor; // 设置 layer背景色
sLayer.strokeColor = [UIColor blueColor].CGColor; // 设置描边色
sLayer.fillColor = [UIColor redColor].CGColor; //设置填充色
sLayer.lineWidth = 4;
UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 100, 100)];
sLayer.path = path.CGPath;
</pre>

### CAGradientLayer

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













