#  View Transform

不改变view的 bounds和center，改变view的外形（大小、方向、位移等）

## CGAffineTransform

affine [ə'faɪn]  仿射。表示形变是用了几何学上的仿射来计算实现的（是用一个 3x3的矩阵来实现的）。

### 3种基本的形变

以 CGAffineTransformMake__ 开头

- CGAffineTransformMakeRotation：旋转形变
- CGAffineTransformMakeScaling：缩放形变
- CGAffineTransformMakeTranslation：位移形变

每个View默认其实都会有一个形变 ，称之为 CGAffineTranformIdentity，但是这个形变对View本身是没有任何变化的。

比如下面转动45度的代码:

<pre>

    view1.transform = CGAffineTransformMakeRotation(45 * M_PI / 180.0);
    
</pre>

- 形变后 bounds不变，center不变

我们在view1的中点画了一个红点，可以注意到在view1旋转的过程中，这个红点没有移动，说明其center并没变（你可以用手指按着红点位置看它移动了没有^_^）

- 形变后 frame发生了改变！

在stage1中我用一个红框表示view1的 frame映射的矩形区域。

- 子view随着父view形变而变

可以注意到 view1的标签会随之一起转动！


### 联合形变

stage2中

<pre>

// view2 先右移再旋转
view2.transform = CGAffineTransformMakeTranslation(50, 0);
view2.transform = CGAffineTransformRotate(view2.transform, 1 / 4.0 * M_PI);

// view2 先旋转再右移
CGAffineTransform r = CGAffineTransformMakeRotation(1 / 4.0 * M_PI);
CGAffineTransform t = CGAffineTransformMakeTranslation(50, 0);
view2.transform = CGAffineTransformConcat(r, t);

// 任意变型 （拉伸）
 view2.transform = CGAffineTransformMake(1, 0, -0.2, 1, 0 , 0);

// 还原一个view的形变
view2.transform = CGAffineTransformIdentity;

</pre>






