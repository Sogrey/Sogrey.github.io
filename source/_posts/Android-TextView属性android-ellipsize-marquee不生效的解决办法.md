---
title: 'Android中TextView属性ellipsize=marquee不生效的解决办法'
date: 2018-03-26 18:35:54
tags: [Android,marquee]
author: Sogrey
categories: Android
comments: true
toc: true
---

Android TextView实现文字跑马灯效果有两种办法：

1、 TextView的Text值赋值后不更改，很多帖子上说如下写法就可以生效：

``` xml

            <TextView
                android:id="@+id/music_name_tv"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:ellipsize="marquee"   【必须】
                android:focusable="true"      【必须】
                android:focusableInTouchMode="true" 【必须】
                android:lines="1"              【必须】
                android:text="我的中国心我的中国心我的中国心我的中国心我的中国心我的中国心我的中国心我的中国心我的中国心xxxx"
                android:textColor="@color/colorAccent"
                android:textSize="15sp" />
```

2、 TextView的文字动态赋值，这个时候直接写在布局Xml里面已经不生效了，需要先给TextView赋值，然后再在代码里面重新把属性设置一遍(亲试可行)：

``` java
  public static void setTextMarquee(TextView textView) {
        if (textView != null) {
            textView.setEllipsize(TextUtils.TruncateAt.MARQUEE);
            textView.setSingleLine(true);
            textView.setSelected(true);
            textView.setFocusable(true);
            textView.setFocusableInTouchMode(true);
        }
    }
```

建议第二种。