#  UIImage 与 UIImageView



## UIImageView

### contentMode

具体的效果见示例的stage1

一共有以下几种模式，留意几点就可以方便记忆：

1. 有Aspect 的就是等比缩放;
2. Fill是填充，即最短的一个方向也要拉至全铺满，使整个ImageView占满图片（可能会超出View大小）；
3. Fit就是缩放到最长的一边填满View即可（不会超出View大小）。

<pre>

typedef NS_ENUM(NSInteger, UIViewContentMode) {
    UIViewContentModeScaleToFill,  // 拉伸至上下左右都填满（非等比）
    UIViewContentModeScaleAspectFit, // 等比拉伸（不会超出View大小）
    UIViewContentModeScaleAspectFill,     // 等比拉伸至填满（会超出View大小）
    UIViewContentModeRedraw,              // 重绘
    UIViewContentModeCenter,              // 居中，原图大小
    UIViewContentModeTop,   // 后面这些都是显示原图大小，只不过显示的位置不同而已
    UIViewContentModeBottom,
    UIViewContentModeLeft,
    UIViewContentModeRight,
    UIViewContentModeTopLeft,
    UIViewContentModeTopRight,
    UIViewContentModeBottomLeft,
    UIViewContentModeBottomRight,
};

</pre>


## UIImage


### imageNamed: 方法

1. 会按优化级从两个地方读取图片资源

- Asset catelog（优化级更高）
- app bundle 根目录

2. 系统会自动帮你完成图片的内存管理。

比如 ***缓存机制*** 用过的图片会缓存在内存中，下次读取时直接从内存中取之.

<pre>

    // 下面的方法将不会自动缓存读取的图片。
    imageWithContentsOfFile:
    initWithContentOfFile:
    
</pre>

3. ***按需而取*** 会根据你设备的分辨率，自动先择对话的 2x 或 3x 图片。


### resizingMode

当图片需要拉伸时，可以设置图片的拉伸方式，有两种：

- UIImageResizingModeTile： 平铺填充
- UIImageResizingModeStretch： 拉伸填充

看示例效果就行了


### renderMode

可以通过设置图片的 renderMode来让图片以mask的方式显示，也就是丢弃图片象素点的颜色信息，只显示象素点。

- tint  [tɪnt] n.色彩；浅色 ; vt. 染色；给..着色

但是象素点显示成什么颜色呢？由 View的tintColor（底色）属性来控制。这个属性如果没有设置则从父View中继承，也就是说，整个App的tintColor默认就是window的tintColor，默认是蓝色。

在renderMode示例中，可以看到，继承父View tintColor的图片显示为默认的蓝色，我们可以通过修改父View的tintColor改变之。
我们还可以直接设置imageView的 tintColor来自己指定 tintColor。
















