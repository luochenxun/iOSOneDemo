#  Animation 概述


## 动画是怎么发生的


### 重绘

1. 当view 可视属性修改时，触发重绘
2. 手动调用 setNeedsDisplay

- 当view 可视属性修改时，触发重绘

当我们改变一个View的可视属性时，UI的变化并不是马上呈现到屏幕中的。事实上系统会把这个修改记下来，然后对这个View进行一次标记，标记它即将重绘(redraw)。如果有多个修改，系统会将之构造在一起，在你这段代码运行结束时或系统空闲时对屏幕进行重绘(这一重绘时刻，也称之为 redraw monment)。

所以，这解释了下面的语句为什么不会造成view闪烁，因为只有最后一个修改会最终生效，绘制于屏幕上。

<pre>
view.backgroundColor = UIColor.redColor;
view.backgroundColor = UIColor.yellowColor;
view.backgroundColor = UIColor.greenColor;
</pre>


- 手动调用 setNeedsDisplay


当你手动调用 ***setNeedsDisplay*** 时，也会对些View标记，并在下个重绘时刻(redraw monment)重绘之。

### 动画

与重绘一样，当你想开始一段动画时，也得等到重绘时刻动画才会真正开始。

当你把 view 从 position1 移动 position2时，会发生如下事情 ：

1. View的center这个可视的位置属性，被设置成 position2；但是还没有到重绘时刻，所以view现在看起来还在 position1位置；
2. 设置完position属性后的代码继续运行；
3. 重绘时刻终于来临，如果没有动画的话，view会马上被重绘到 position2 的位置。如果有动画，则会开始view从position1到position2的动画。动画结束，把view放在position2位置上。
4. 如果有动画的话，动画播完后会被移除，现在view的属性与看起来的位置都在position2上。

做动画时，要确保的一点就是，动画放完之后，view当前的属性与动画结束时的属性应该是一致的。


### 动画发生的线程

动画是在一个独立的线程中发生的。

其实动画不仅使用了多线程技术，还使用了“多图层技术”。我们平时看到的layer其实不是layer本身，是它的 ***presentation layer***，你可以通过  ***presentationLayer*** 这个属性获得它；

当你通过修改一个view或layer的可视属性来开始一个动画时，layer的这个可视属性也跟着立马就变了，但是它的 ***presentation layer*** 却没变。直到我们所说的重绘时刻发生时，***presentation layer*** 才会随着时间改变，这就形成了动画！

动画是有可能被打断的 -- 比如当你点了Home键或突然来电，你的动画就会马上停止，view的可视状态会马上修改成动画后它应该显示成的状态。所以，你的界面不会因此而混乱。


















