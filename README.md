DSScrollController
==============
-------------------------------
####基于ScrollerView进行的封装，可实现 滑动切换控制器，无限轮播功能
-------------------------------------------------------------------

1，本地加载图片的轮播器（传进去一个图片数组）

self.ScrollViewTwo.viewControlls = imageArray;

2，设置可左右滚动的控制器 （传进去一个控制器数组）

TabViewOne *one = [[TabViewOne alloc]init];

TabViewTwo *two = [[TabViewTwo alloc]init];

self.ScrollViewOne.viewControlls = @[one,two];

---------------------------------------------------------------------------------------------------------------
###<a name="pic"/>效果

![](http://i4.tietuku.com/c59cbc900765e0ab.gif)
