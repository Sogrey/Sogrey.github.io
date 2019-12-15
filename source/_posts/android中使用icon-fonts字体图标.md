---
title: android中使用icon fonts字体图标
date: 2017-01-16 14:39:21
tags: [android,icon font字体图标]
categories: Android
---

> IconFont字体不仅仅流行于Web开发，在移动开发中也渐渐的使用的范围更广泛。这篇文章主要介绍了在Android开发中使用icon font的代码和方法。

<!-- more -->
# 1 Icon fonts介绍

对于可缩放的自适应设计来讲，Icon fonts是一种惊人的解决方案。

在开发native app时，你应该记住icon fonts技术有多项超过位图的高级特性，这些特性所带来的好处会影响你的设计工作流，以及产品的最终品质。

**可缩放性（Scalability）：**

基于字体的icon是与分辨率无关并能缩放到任何想要程度的技术。你的图标看起来毫不关心retina,HDPI,XHDPI等等屏幕，但渲染时会根据目标设备自动调整，你将有能力应对任何当下，未来，或大多数任意规格的设备

**尺寸（Size ）：**

裁剪到正确的比例，icon font的文件的大小要比起位图小到难以置信的程度，使用icon font时，你不需要根据不同设备准备不同的图片，你的APP只需要在启动时加载一次icon font文件即可。

**可维护性（ Maintainability ）：**

自你的icon打包进一个字体文件，在项目自始至终你仅需要维护这个单一的字体文件。

通过管理字体文件你可以很自然的组织你的icon集合，任意的进行修改或扩展

**可推广性（Adoption）：**

然而，应用这样的icon fonts可能会影响你和你同事之间的工作流程，但说服让他们采用这样的技术也非常简单，有数款免费或收费的工具帮你轻松达到目的并能看到很好的应用结果，在几乎任意（手机）移动平台、浏览器或操作系统

**灵活性（Flexibility）：**

应用icon fonts技术中最有意义的一项能力是可以操纵icon fonts， 改变颜色，大小，仅仅几行代码就可以在瞬间改变外观

**可交互性(Interactivity)：**

由于灵活性以及能够通过代码方便的操纵，icon fonts 是独一无二的在运行时被操纵，通过应用icon fonts技术， 你能轻松的在不同状态显示对应的不同效果，创建动画。

# 2 Icon fonts优缺点

字体图标是指将图标做成字体文件（.ttf），从而代替传统的png等图标资源。
使用字体图标的优点和缺点分别为： 
优点： 

      1. 可以高度自定义图标的样式（包括大小和颜色)，对于个人开发者尤其适用 
      2. 可以减少项目和安装包的大小（特别你的项目中有很多图片icon时，效果将是M级） 
      3. 几乎可以忽略屏幕大小和分辨率，做到更好的适配
      4. 使用简单 
      …… 
缺点： 

      1. 只能是一些简单的icon，不能代替如背景图、9图等资源 
      2. 一些需要文字说明的icon，图片资源将会是更好的选择 
      3. 对设计的要求更高，不同icon可能拥有不同的边距，这时要切换icon时还要设置大小 
      4. 由于边距的存在可能存在无法填满控件的情况 
      5. 无法在Android studio中进行实时预览

iconfont对于客户端应用来说有很多便捷：

      1. 自由变化大小
      2. 自由修改颜色
      3. 可以添加一些视觉效果如：阴影、旋转、透明度。
      4. 比单位的图片更节省资源

# 3 获取字体文件
icon font字体文件来源很多，我这里列出两个（在文章尾[参考#字体图标库](#参考)）。

这里以[http://fontawesome.io/cheatsheet/](http://fontawesome.io/cheatsheet/)为例，其github仓库是[https://github.com/FortAwesome/Font-Awesome/](https://github.com/FortAwesome/Font-Awesome/),我们的字体文件就是从[这里获取](https://github.com/FortAwesome/Font-Awesome/blob/master/fonts/fontawesome-webfont.ttf)，获取到的字体文件是以`.ttf`为后缀的字体文件。

# 4 在Android项目中使用
## 4.1 新建Android项目
打开Android studio新建一个Android项目，我新建一个包名为`org.sogrey.iconfont.demo`的应用，具体新建步骤就不赘述了。另再新建一个Module包名为`org.sogrey.iconfont`的库应用，结构如下：
![新建Android项目](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-17_001301.jpg)

## 4.2 在库应用中引入`.ttf`字体
在库应用中引入`.ttf`字体，放在`assets`文件夹下，新建java类`IconFontTextView`继承自`android.widget.TextView`,结构如下：

![在库应用中引入`.ttf`字体](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-17_002541.jpg)

IconFontTextView.java代码：

```java
package org.sogrey.iconfont;

import android.content.Context;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.widget.TextView;

/**
 * 适用于fontawesome的字体TextView
 * Created by Sogrey on 2017/1/17.
 */

public class IconFontTextView extends TextView {
    public IconFontTextView(Context context) {
        this(context,null);
    }

    public IconFontTextView(Context context, AttributeSet attrs) {
        this(context, attrs,0);
    }

    public IconFontTextView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context, attrs, defStyleAttr);
    }

    private void init(Context context, AttributeSet attrs, int defStyleAttr) {
        Typeface iconfont = Typeface.createFromAsset(context.getAssets(), "fontawesome-webfont.ttf");
        this.setTypeface(iconfont);
    }
}
```

## 4.3 在Application中使用
下面就正式来使用icon font了，在app的build.gradle中引用刚刚的IconFont库：

	compile project(':lib_iconfont')

activity_main.xml布局中放几个`IconFontTextView`,其string属性设置为以`&#`开头的字符串，以通讯录图标为例:

![通讯录图标icon font](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-17_003852.jpg)

前面的图标就是最终要实现的效果，`fa-address-book`用在html标签的class类属性中，而我们要用的是后面放括弧中的`&#xf2b9;`。

xml布局文件：

```xml
<org.sogrey.iconfont.IconFontTextView
    android:id="@+id/text1"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="&#xf2b9; 通讯录" />
```

编译运行即可看到效果。

![运行效果](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-17_005941.jpg)

预览一下全部图标：

![预览一下全部图标](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-17_010816.jpg)

附：在[https://icomoon.io/app](https://icomoon.io/app)可定制你需要的图标打包成字体文件下载引用，具体方法可参考[如何在Android使用图标字体？](http://blog.csdn.net/ruihanchen/article/details/50032841)。

demo看[这里](https://github.com/Sogrey/IconFontTextView)，Good luck!




# 参考

字体图标库

* [http://fontawesome.io/cheatsheet/](http://fontawesome.io/cheatsheet/)
* [https://icomoon.io/app](https://icomoon.io/app)

参考

* [如何在移动端app中应用字体图标icon fonts](http://www.tuicool.com/articles/Mn2ARv)
* [Android中正确使用字体图标(iconfont)的方法](http://www.jb51.net/article/94880.htm)
* [如何在Android使用图标字体？](http://blog.csdn.net/ruihanchen/article/details/50032841)
* [在Android开发中使用icon font的代码和方法](http://www.weste.net/2013/12-13/94695.html)