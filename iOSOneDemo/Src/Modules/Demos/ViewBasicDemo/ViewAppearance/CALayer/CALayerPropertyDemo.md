#  CALayer 边框、阴影等显示属性

CALayer 有许多内置的属性，这些属性可以帮助你方便地创造出各种静态特效，比如给图片加边框，制作圆角等。

我们先罗列 CALayer的主要属性与方法，然后着重介绍其中的几个常用的静态视觉效果。


## CALayer的主要属性与方法

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



## backgroundColor, opaque , opacity

这几个属性与UIView的几个属性很相近。

- backgroundColor

layer的这个属性与view是联动的，实际上设置view的backgroundColor就是在设置layer的backgroundColor.

- opacity

与backgroundColor一样，与view的 alpha属性是联动的。

- opaque

此属性不与view联动。主要控制layer的不透明效果。在绘图时使用 clear方法时可见此效果，不透明的就显露底色（默认黑色），否则显示透明效果。这个属性与View一样，对提升UI性能有重要关系，在不影响显示的情况下，设置其为YES，可以降低渲染复杂度，提升性能。


## 边框 - borders

主要属性

<pre>
borderWidth, borderColor， cornerRadius

cornerRadius - 设置layer边界圆角。
</pre>

## 阴影-shadows

与阴影有关的主要属性。***要注意的是如果view使用了 clipsToBounds为YES，layer设置了marksToBounds的话，阴影就显示不出来了***

<pre>
shadowColor, shadowOpacity, shadowRadius,  shadowOffset .

- shadowColor 阴影颜色
- shadowOpacity 阴影透明度
- shadowRadius 阴影半径
- shadowOffset 阴影的位移
- shadowPath 阴影形状（比如圆形的阴影）
</pre>


### 使用边框与阴影制作卡片

<pre>
UIView *cardView = [UIView new];
cardView.backgroundColor = [UIColor whiteColor];
cardView.layer.borderWidth = kAppDimension.lineWidth;
cardView.layer.borderColor = kAppColor.dividerDark.CGColor;
cardView.layer.cornerRadius = 6.0;
cardView.layer.shadowColor = UIColor.blackColor.CGColor;
cardView.layer.shadowOpacity = 0.5;
cardView.layer.shadowRadius = 5.0;
cardView.layer.shadowOffset = CGSizeMake(2, 4);
</pre>


### 给图片加阴影

图层的阴影继承自内容的外形，而不是根据边界和角半径来确定。为了计算出阴影的形状，Core Animation会将寄宿图（包括子视图，如果有的话）考虑在内，然后通过这些来完美搭配图层形状从而创建一个阴影。

从下面这个给图片加阴影的示例中我们可以看出，CA会根据图片的内容自动生成对应的阴影！

<pre>
CALayer *layer = [CALayer new];
layer.frame = CGRectMake(0, 0, 100, 100);
UIImage *img = [UIImage imageNamed:@"rain"];
layer.contents = (id)img.CGImage;
layer.shadowColor = UIColor.blackColor.CGColor;
layer.shadowOpacity = 0.5;
layer.shadowRadius = 5.0;
layer.shadowOffset = CGSizeMake(2, 4);
[frameView.layer addSublayer:layer];
[demo1 flex_addSubview:frameView];
</pre>


## 图层蒙板-masks

当设置一个图层为另一个图层的mask属性时，如下：

<pre>
A.mask = B;
</pre>

相当于声明图层B为 mask图层。一个图层设置为mask图层后，其所有颜色信息都会忽略，只省一个轮廓。相当于以其为蒙板，用B的轮廓切割A图层, 如下图：

![mask](./MDImage/layer-mask.png)

示例，我们做一个渐变色的文字：

<pre>
// mask属性制作渐变色字
CAGradientLayer *gradientLayer = [CAGradientLayer layer];
gradientLayer.contentsScale = [UIScreen mainScreen].scale;
gradientLayer.frame = CGRectMake(0, 0, 200, 30);
[gradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
[gradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
gradientLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor];

// label
CATextLayer *labelLayer =[CATextLayer layer];
labelLayer.contentsScale = [UIScreen mainScreen].scale;
labelLayer.string = @"红黄绿渐变~~";
labelLayer.bounds = CGRectMake(0, 0, 200, 30);
labelLayer.font = (__bridge CFTypeRef _Nullable)(@"HelveticaNeue-BoldItalic");
labelLayer.fontSize = 20.f; //字体的大小
labelLayer.position = CGPointMake(100, 15);
labelLayer.foregroundColor =[UIColor blackColor].CGColor; //字体的颜色

UIView *layerFrame = [UIView new];
[layerFrame.layer addSublayer:gradientLayer];
gradientLayer.mask = labelLayer; // 注意要先添加layer再设置mask
</pre>



## 拉伸过滤

minificationFilter 和 magnificationFilter 属性

当我们视图显示一个图片的时候，都应该以正常的比例显示这个图片：

原因如下：

- 能够显示最好的画质，像素既没有被压缩也没有被拉伸。
- 能更好的使用内存，因为这就是所有你要存储的东西。
- 最好的性能表现，CPU不需要为此额外的计算。

不过有时候，显示一个非真实大小的图片确实是我们需要的效果。比如说一个头 像或是图片的缩略图，再比如说一个可以被拖拽和伸缩的大图。这些情况下，为同 一图片的不同大小存储不同的图片显得又不切实际。

当图片需要显示不同的大小的时候，有一种叫做拉伸过滤的算法就起到作用了。 它作用于原图的像素上并根据需要生成新的像素显示在屏幕上。

CALayer 为此提供了三种拉伸过滤方法，他们是：

1. kCAFilterLinear
2. kCAFilterNearest
3. kCAFilterTrilinear

minificationFilter 和 magnificationFilter 属性可以设置当缩小与放大图片时，使用哪个过滤器。

- kCAFilterLinear（默认）

kCAFilterLinear ，这个过滤器采用双线性滤波算法，它在大多数情况下都表 现良好。双线性滤波算法通过对多个像素取样最终生成新的值，得到一个平滑的表现不错的拉伸。但是当放大倍数比较大的时候图片就模糊不清了。

- kCAFilterTrilinear

kCAFilterTrilinear与kCAFilterLinear非常相似，大部分情况下二者都 看不出来有什么差别。但是，较双线性滤波算法而言，三线性滤波算法存储了多个 大小情况下的图片（也叫多重贴图），并三维取样，同时结合大图和小图的存储进 而得到最后的结果。

- kCAFilterNearest

kCAFilterNearest是一种比较武断的方法。从名字不难看出，这个算法（也 叫最近过滤）就是取样最近的单像素点而不管其他的颜色。这样做非常快，也不会 使图片模糊。但是，最明显的效果就是，会使得压缩图片更糟，图片放大之后也显 得块状或是马赛克严重。


- 简单地说

简单地说就是 kCAFilterLinear与kCAFilterTrilinear都会在缩放时通过增加一些插值颜色，使效果更平滑些。而kCAFilterNearest不会增加颜色，而会取最近的一个单色都填充或过滤。通常，如果颜色值较小，纯色较多，使用kCAFilterNearest效果更好；一般的多色彩的图片，使用前两者会更好。











