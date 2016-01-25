DSScrollController
===========================
基于ScrollerView进行的封装，可实现 滑动切换控制器，无限轮播功能

### 使用设置说明(一步设置即可使用)

// 本地加载图片的轮播器（传进去一个图片数组）
self.ScrollViewTwo.viewControlls = imageArray;

// 设置可左右滚动的控制器 （传进去一个控制器数组）
TabViewOne *one = [[TabViewOne alloc]init];
TabViewTwo *two = [[TabViewTwo alloc]init];
self.ScrollViewOne.viewControlls = @[one,two];

---------------------------------------------------------------------------------------------------------------
##<a name="pic"/>显示图片
###来源于网络的图片
![](http://i4.tietuku.com/c59cbc900765e0ab.gif)
