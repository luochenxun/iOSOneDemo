#  View Coordinate System


## frame

frame是基于父坐标系中的View的位置与大小的一个结构表述。
origin 表示其左上角位置，size表示其大小。

## bounds & center

- view的位置与大小其实真正上来说是由 bound与 center决定的。

- center 决定View在父View中的位置；
- bounds 决定View的大小；
- frame 实际上是由center + bounds计算出来的一个方便理解的结构。

所以，当你修改 frame时，center & bounds都会变，当你改frame.origin时，center变；改frame.size时，bounds变。

### 当bounds改变时

在Stage2中我特意把外层的View2弄成深色点，点按钮改变View3的bounds后，将之透明度降低，可以看到我改大了View3的bounds
<pre><code>
// 初始view3 frame
view3.frame = CGRectInset(view2.bounds, 30, 10);

// 修改view3大小
CGRect r = view3.bounds;
r.size.height += 40;
r.size.width += 40;
view3.bounds = r;
</code></pre>
可以看到View3的大小改变了，但是其Center没变！

而我修改bounds的origin时，意味着该View内部的坐标轴发生变化！
就像在state2中发生的一样：当我对view2的bounds中origin的x&y各增加10，可以看到view3向左上移动了，因为view2的bounds决定自身的坐标轴，当view2的origin增加10，说明左上的点由(0,0)变成(10,10)，也就是在View2内部，坐标轴整体左上斜移了。因为view3的center点不变，这就会导致view3也跟着往左上斜移。


## PS：输出常用CG结构体(将之转为字符串)的方法

<pre><code>

NSString *NSStringFromCGPoint(CGPoint point);
NSString *NSStringFromCGVector(CGVector vector);
NSString *NSStringFromCGSize(CGSize size);
NSString *NSStringFromCGRect(CGRect rect);
NSString *NSStringFromCGAffineTransform(CGAffineTransform transform);
NSString *NSStringFromUIEdgeInsets(UIEdgeInsets insets);
NSString *NSStringFromUIOffset(UIOffset offset);


反之，由字符串转结构体：
CGPoint CGPointFromString(NSString *string);
CGVector CGVectorFromString(NSString *string);
CGSize CGSizeFromString(NSString *string);
CGRect CGRectFromString(NSString *string);
CGAffineTransform CGAffineTransformFromString(NSString *string);
UIEdgeInsets UIEdgeInsetsFromString(NSString *string); //距离边界的距离,上左下右的顺序!
UIOffset UIOffsetFromString(NSString *string);

</code></pre>










