#  隐式动画


## 什么是隐式动画

每一个UIView内部都默认关联着一个CALayer，我们可用称这个Layer为Root Layer（根层）

所有的非Root Layer，也就是手动创建的CALayer对象，都存在着隐式动画


当对非Root Layer的部分属性进行修改时，默认会自动产生一些动画效果

而这些属性称为Animatable Properties(可动画属性)

可以通过动画事务(CATransaction)关闭默认的隐式动画效果


## 动画事务

隐式动画与事务相关
