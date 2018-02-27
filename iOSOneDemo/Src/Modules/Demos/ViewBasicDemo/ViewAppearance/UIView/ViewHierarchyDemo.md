#  View Hierarchy

我们在说View关于“形”的主要方面时，说到View的2个主要概念：

1. View的可视区域是一个矩形区域；
2. View使用“层级(Hierarchy)”的树型模型来进行界面管理；

而关于这个层级的管理，有以下几个重要的概念：

1. View的可视范围与子View的可视范围；
2. View层级的顺序问题( view order )；
3. 层级的关联性（即层级之间是怎样管理的）；


## View的可视范围

从右边的例子中我们可以看到，View2及子View的从属关系。

*   子View是可以显示在父View的区域之外的；
*   可以使用clipsToBounds来控制子View的显示范围，比如示例中控制View2的子View的显示范围；


## 层级的关联性

修改父View的透明度、位置、可见性等属性，子View也会跟着一块改变。但要注意的是，比如透明度，这里改父View的alpha值会使包括子View在内的View整体透明值改变，但是作为子View个体，其alpha值没变，其单体的透明度也是没有变的。

### 透明度

修改父View的透明度子View的透明度也会跟着一块变。

* 但是这里要注意下，这里修改父View的透明度，子View的alpha值其实没变！这里你可以操作下修改View2的透明度，再修改下View3的透明度，对比下这里微妙的区别！


### 位置

父View的frame改变，子View会发生变化 ：
1. 子View的大小**不会**随着父View frame大小变化；
2. 子View的位置**会**随着父View 的位置而变化；

## 关于View层级的主要方法

<pre><code>
- 打印View的层级，这个是私有方法，可以用于调试器
    [view recursiveDescription]

- 裁剪显示在父View之外的子View界面
    clipsToBounds
    
    superview -> 指向View的父View
    subviews -> 指向View的所有子View
    isDescendantOfView -> 判断一个View是否是一个View的子孙
    viewWithTag: -> 一个View可以有一个Tag，使用此属性可以从父View中找到拥有些Tag的子View
</code></pre>










