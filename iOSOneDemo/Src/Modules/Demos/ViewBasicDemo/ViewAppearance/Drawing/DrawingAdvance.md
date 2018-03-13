#  绘图进阶


## 总述

Quartz 2D是一个二维绘图引擎，同时支持iOS和Mac系统。具有如下特性：

1. 它是一个图像框架，基于OpenGL顶层创建，底层则用着色器来处理图像；
2. 它利用了GPU基于硬件加速来处理图像；
3. Core Image 中有很多滤镜；

Quartz 2D可以完成许多工作：

1. 绘制图形 : 线条\三角形\矩形\圆\弧等;
2. 绘制文字;
3. 绘制\生成图片(图像);
4. 读取\生成PDF;
5. 截图\裁剪图片;
6. 自定义UI控件;

## GraphicsContext

### Graphics Context 关键点

1. 画布说；
2. 保存现场与恢复理场;


### 画布说

图形上下文就相当于画布，不同类型的画布就是决定着画得内容将展示在哪里。

Quartz2D提供了以下几种类型的Graphics Context：

1. Bitmap Graphics Context 位图上下文，在这个上下文上绘制或者渲染的内容，可以获取成图片（需要主动创建一个位图上下文来使用，使用完毕，一定要销毁）
2. PDF Graphics Context
3. Window Graphics Context
4. Layer Graphics Context 图层上下文，针对UI控件的上下文
5. Printer Graphics Context 打印机上下文

### 保存现场与恢复理场

GraphicsContext是一个存储了各种绘画信息的对象。当你绘画时，就使用了这样一个绘画信息对象。

因此，当你想画出你想要的图形时，必须对之进行配置。

比如你想画一条红色的线，在画之前，你要先把 GraphicsContext的画线的color设置为red,然后再去drawLine。如果下一条线你想画成蓝色的，那么得将context画线color设置为blue，再去调用drawLine画蓝线。（使用Quartz2D绘图，和OpenGL等的绘图方式是一样的，估计这种Context配置，再使用绘图方法绘图的方式是图形接口的标准了，呵呵^_^）

但是这样也有一个问题，就是你不想每次都去配置Context这么麻烦，有些配置应该是可以复用的。 --- 设计者也想到了这个问题，提供了一个stack容器去装载Context对象。

一个时刻在途使用的context称之为state，保存了当前满足需求的所有绘图信息。你可以调用 CGContextSaveGState，把当前使用的Context入栈保存；也可以调用 CGContextRestoreGState将栈顶的state取出作为当前使用的state。


### 获得 Graphics Context的几种方式

1. UIView的drawRect: 方法

#### UIView的drawRect: 方法

Q：为什么要实现drawRect:方法才能绘图到view上？
A：因为在drawRect:方法中才能取得跟view相关联的图形上下文；取得上下文后，就可以绘制东西到view上

View内部有个layer（图层）属性，drawRect:方法中取得的是一个Layer Graphics Context，因此，绘制的东西其实是绘制到view的layer上去了。View之所以能显示东西，完全是因为它内部的layer（这个后面的章节会总结）。

- drawRect:方法的调用？

1. 当view第一次显示到屏幕上时，系统会创建好一个跟当前view相关的Layer上下文
2. 系统会通过此上下文，在drawRect:方法中绘制好当前view的内容
3. 主动让view重绘内容的时候，调用setNeedsDisplay或者setNeedsDisplayInRect:。我们主动调用drawRect:方法是无效的。
4. 调用view的setNeedsDisplay或者setNeedsDisplayInRect:时。
注意：setNeedsDisplay和setNeedsDisplayInRect:方法调用后，屏幕并不是立即刷新，而是会在下一次刷新屏幕的时候把绘制的内容显示出来。
5. 也正是系统会在调用这个方法之前创建一个与该view相关的上下文，才让我们可以在drawRect:方法中绘制。

### 知识点总结

1. 入栈CGContextSaveGState(cox)
2. 出栈CGContextRestoreGState(ctx);
3. 如果出战的次数大于入栈，就会***奔溃***；
4. 什么是入栈？就是拷贝当前图形上下文，然后放到栈中，因为使用CGContextRef，只有一个图形上下文，所以要拷贝！
5. 出战的上下文，将样式赋值给当前样式，然后释放；

### 一个具体的例子

### 常用的 context 设置




## Paths & Shapes

1. path是什么；
2. strok & fill；
3. context是怎样画路径的；

- path是什么

path 就是路径，用来形容画画时的笔触。比如我们画画时从A点画条直线到B点，这条连线就叫path。

- strok & fill

stroke [strok] vt. 画；敲击
stroke就是画线，用设置好的画笔属性（线粗细、颜色等）去描绘你规划好的path。
fill 会高级点，他会分析你规划的path，对其中封闭的区域使用设置好的画笔属性去填充之。

比如示例中的例子：

<pre>

</pre>

- context是怎样画路径的

从示例我们可以看出，首先，我们要利用path的api移动点与连接，规划好要绘制的路径。然后调用stroke或fill真正地将之渲染到context中去。而这个渲染过程结束后，也就是调用了stroke或fill之后，context中当前的path将被清空，这就意味着你stroke之后马上调用fill就不能填充出图画了。















