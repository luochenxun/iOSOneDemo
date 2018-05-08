#  CALayer Transform


和UIView一样，CALayer也可以设置 Transform（那当然，因为uiview的绘图就是靠layer来实现的），而且layer的transform比view来说要强大的多。



## 仿射变换

在介绍 UIView的几何变形时，我们提到了通过赋值view的 transform属性，可以设置view的几何变换。我们之所以称之为“几何”变形，就是因为对图象的变型操作实际上是利用了几何的知识。

比如我们常用的, CGAffineTransform中的 affine，就是仿射变换，用于在二维空间对图象进行几何变换（缩放、平移、旋转等）。他是利用将图象和一个变换矩阵相乘以得出的结果矩阵来实现变换的。

在应用的时候，我们无需理解其中复杂的几何计算，因为CALayer提供了简单的api供我们使用，我们只需要改变layer的***affineTransform***属性。

<pre>
CGAffineTransformIdentity 【常量】什么都不做的变换（初始变换）

- CGAffineTransformMakeRotation(CGFloat angle)
旋转变换
- CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
缩放变换
- CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
平移变换

复合变换
CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)

CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2);

</pre>

下面有一个输出一个指南针图层的实例，利用变形知识画一个指南针：

<pre>

- (CALayer *)compassLayer
{
    CALayer *outerLayer = [CALayer new];
    outerLayer.frame = CGRectMake(0, 0, 300, 300);

    // 表底盘(渐变 CAGradientLayer)
    CAGradientLayer *outletLayer = [CAGradientLayer new];
    outletLayer.contentsScale = [UIScreen mainScreen].scale;
    outletLayer.frame = outerLayer.bounds;
    outletLayer.colors = @[(id)[UIColor greenColor].CGColor, (id)[UIColor redColor].CGColor];
    outletLayer.locations = @[@0.0f, @1.0f];
    [outerLayer addSublayer:outletLayer];

    // 表面(CAShapeLayer)
    CAShapeLayer *surfaceLayer = [CAShapeLayer new];
    surfaceLayer.bounds = outerLayer.bounds;
    surfaceLayer.position = CGPointMake(CGRectGetMidX(outerLayer.bounds),CGRectGetMidY(outerLayer.bounds));
    surfaceLayer.contentsScale = [UIScreen mainScreen].scale;
    surfaceLayer.lineWidth = 3.0;
    surfaceLayer.fillColor = XXXX_COLOR_HEX(0xf5f5f5).CGColor;
    surfaceLayer.strokeColor = [UIColor blueColor].CGColor;
    CGMutablePathRef p = CGPathCreateMutable();
    CGPathAddEllipseInRect(p, nil, CGRectInset(outerLayer.bounds, 3, 3));
    surfaceLayer.path = p;
    [outerLayer addSublayer:surfaceLayer];

    // 四个方向的文字(CATextLayer)
    NSArray* pts = @[@"北", @"东", @"南", @"西"];
    for (int i = 0; i < 4; i++) {
        CATextLayer *textLayer = [CATextLayer new];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.string = pts[i];
        textLayer.bounds = CGRectMake(0,0,50,50);
        textLayer.position = CGPointMake(CGRectGetMidX(surfaceLayer.bounds), CGRectGetMidY(surfaceLayer.bounds));
        CGFloat vert = CGRectGetMidY(surfaceLayer.bounds) / CGRectGetHeight(textLayer.bounds);
        textLayer.anchorPoint = CGPointMake(0.5, vert);
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.foregroundColor = [UIColor blackColor].CGColor;
        textLayer.affineTransform = CGAffineTransformMakeRotation(i*M_PI/2.0);
        [surfaceLayer addSublayer:textLayer];
    }

    // the arrow
    CALayer *arrow = [CALayer new];
    arrow.contentsScale = [UIScreen mainScreen].scale;
    arrow.bounds = CGRectMake(0, 0, 10, 130);
    arrow.backgroundColor = [UIColor blackColor].CGColor;
    arrow.position = CGPointMake(CGRectGetMidX(outerLayer.bounds), CGRectGetMidY(outerLayer.bounds));
    arrow.anchorPoint = CGPointMake(0.5, 1);
    arrow.affineTransform = CGAffineTransformMakeRotation(M_PI/5.0);
    [outerLayer addSublayer:arrow];

    return outerLayer;
}
</pre>



## 3D变换

CG的前缀告诉我们， CGAffineTransform 类型属于Core Graphics框架，Core Graphics实际上是一个严格意义上的2D绘图API，并且 CGAffineTransform 仅仅 对2D变换有效。

CATransform3D 可以对图层在3D空间内进行移动或转动。和 CGAffineTransform 类似， CATransform3D 也是一个矩阵，但是和3x3的矩 阵不同， CATransform3D 是一个可以在3维空间内做变换的4x4的矩阵

![示例图片](./MDImage/layer-3dtransform.png)

### 3D变换主要方法

<pre>
CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz)
CATransform3DMakeTranslation(Gloat tx, CGFloat ty, CGFloat tz)

</pre>


### 背面绘制

CALayer有一个叫做 ***doubleSided*** 的属性来控制图层的背面是否要被绘制。是BOOL 类型，默认为 YES ，如果设置为 NO ，那么当图层正面从相机视角消失的时候，它将不会被绘制。


#### 透视投影

在真实世界中，当物体远离我们的时候，由于视角的原因看起来会变小，理论上说远离我们的视图的边要比靠近视角的边跟短，但实际上，如果你什么都不设置，这样的情况并没有发生。

- m34

CATransform3D 的透视效果通过一个矩阵中一个很简单的元素来控制 -- m34, 可以按比例缩放X和Y的值来计算到底要离视角多远。

<pre>
CATransform3D transform = CATransform3DIdentity;
transform.m34 = -1 / 500.0;
transform = CATransform3DRotate(transform, M_PI * 2 / 100.0 * slider.value, 0, 0, 1);
_projectLayer.transform = transform;
</pre>


#### 灭点

当在透视角度绘图的时候，远离相机视角的物体将会变小变远，当远离到一个极限 距离，它们可能就缩成了一个点，于是所有的物体最后都汇聚消失在同一个点。

在现实中，这个点通常是视图的中心，于是为了在应用中创建拟真效果的透视，这个点应该聚在屏幕中点，或者至少是包含所有3D对象的视图中点。

![示例图片](./MDImage/layer_vanishing.png)

Core Animation定义了这个点位于变换图层的 anchorPoint . 这就是说，当图层发生变换时，这个点永远位于图 层变换之前 anchorPoint 的位置。

当改变一个图层的 position ，你也改变了它的灭点，做3D变换的时候要时刻记 住这一点，当你视图通过调整 m34 来让它更加有3D效果，应该首先把它放置于屏 幕中央，然后通过平移来把它移动到指定位置（而不是直接改变它 的 position ），这样所有的3D图层都共享一个灭点。



#### sublayerTransform属性


如果有多个视图或者图层，每个都做3D变换，那就需要分别设置相同的m34值，并且确保在变换之前都在屏幕中央共享同一个 position 。使用CALayer的 ***sublayerTransform*** 属性会让父层的改变影响到所有的子图层，这意味着你可以一次性对包含这些图层的容器做变换，也就是所有子图层都自动继承了父图层的变换方法。

比如，我们

<pre>
CATransform3D perspective = CATransform3DIdentity;
perspective.m34 = - 1.0 / 500.0;
self.containerView.layer.sublayerTransform = perspective;  // 设置父层的 sublayerTransform！子图层自动继承父图层此变换方法，设置同一个来点

// 然后再分别转动 layer1 与 layer2
CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
self.layerView1.layer.transform = transform1;
CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
self.layerView2.layer.transform = transform2;
</pre>



#### 做一个立方体

<pre>
layerFrame = [UIView new];
layerFrame.backgroundColor = [UIColor greenColor];
layerFrame.flexSize = CGSizeMake(300, 300);
_cube = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
[layerFrame addSubview:_cube];
[demo3 flex_addSubview:layerFrame];

// 设置所有子层共同灭点
CATransform3D perspective = CATransform3DIdentity;
perspective.m34 = -1.0 / 500.0;
layerFrame.layer.sublayerTransform = perspective;

for (int i = 1; i <= 6; i++) {
    UIView *face = self.face[i-1];
    face.backgroundColor = XXXX_RANDOM_COLOR();
    face.frame = CGRectMake(0, 0, 100, 100);
    face.center = CGPointMake(150, 150);
    [_cube addSubview:face];
    XXXXLabel *faceLabel = [XXXXLabel labelWithType:XXXXLabelTypeDefault
                                               text:[NSString stringWithFormat:@"%d", i]
                                               font: [UIFont systemFontOfSize:30]
                                              color:[UIColor blackColor]];
    faceLabel.frame = CGRectMake(0, 0, 50, 50);
    faceLabel.center = CGPointMake(50, 50);
    faceLabel.textAlignment = NSTextAlignmentCenter;
    faceLabel.verticalAlignment = XXXXLabelVerticalAlignmentMiddle;
    [face addSubview:faceLabel];

    CALayer *layer = face.layer;
    CATransform3D transform = CATransform3DIdentity;

    if (i == 1) {
        transform = CATransform3DMakeTranslation(0, 0, 50);
    }
    else if (i == 2) {
        transform = CATransform3DMakeTranslation(-50, 0, 0);
        transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    }
    else if (i == 3) {
        transform = CATransform3DMakeTranslation(0, -50, 0);
        transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    }
    else if (i == 4) {
        transform = CATransform3DMakeTranslation(50, 0, 0);
        transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    }
    else if (i == 5) {
        transform = CATransform3DMakeTranslation(0, 50, 0);
        transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    }
    else if (i == 6) {
        transform = CATransform3DMakeTranslation(0, 0, -50);
    }
    layer.transform = transform;
}

// 根据slider的值旋转立方体
- (void)rotateCube
{
    CATransform3D x = CATransform3DRotate(CATransform3DIdentity, M_PI * 2 / 100.0 * _cubeRotateX, 1, 0, 0);
    CATransform3D y = CATransform3DRotate(CATransform3DIdentity, M_PI * 2 / 100.0 * _cubeRotateY, 0, 1, 0);
    CATransform3D z = CATransform3DRotate(CATransform3DIdentity, M_PI * 2 / 100.0 * _cubeRotateZ, 0, 0, 1);
    CATransform3D transform = CATransform3DConcat(x, y);
    transform = CATransform3DConcat(transform, z);
     _cube.layer.sublayerTransform = transform;
}
</pre>
