#  Core Animation


Core Animation库是 iOS动画技术的基础，由一系列类与子类组成（他们基本都有个特点就是以各种CA开头，如CALayer）。

我们之前学习到的 View动画，隐匿Layer动画等，都是基于 Core Animation库的一个封装实现。Core Animation又称显式动画，使用显示动画技术，我们可以更细致地定义我们要的动画的整个实现过程。

控制动画过程中的插值(intermediate)与调速(timing)；
将各种动画组成复合动画；
自己管理动画事务；


1. 弄清 fromValue , toValue , byValue

byValue ： 转360度，如果只用toValue则根本没有转，因为转360度和转0度是一样的效果！所以要使用byValue, 让之旋转360度，而不是to转到360度后的位置。

Demo1的两个例子
设置layer的animated property时，相当于设置了他的anim的fromValue与toValue！
