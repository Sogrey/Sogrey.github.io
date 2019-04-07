---
title: Android获取view宽高的三种方式
date: 2018-03-26 23:30:27
tags: [Android]
categories: Android
comments: true
toc: true
---

> getMeasuredHeight()与getHeight的区别

实际上在当屏幕可以包裹内容的时候，他们的值相等，
只有当view超出屏幕后，才能看出他们的区别：
getMeasuredHeight()是实际View的大小，与屏幕无关，
而getHeight的大小此时则是屏幕的大小。
当超出屏幕后，getMeasuredHeight()等于getHeight()加上屏幕之外没有显示的大小

<!-- more -->

具体方法

我们知道在oncreate中View.getWidth和View.getHeight无法获得一个view的高度和宽度，这是因为View组件 布局要在onResume回调后完成。

下面说三种方式

* getViewTreeObserver

使用 getViewTreeObserver().addOnGlobalLayoutListener()来获得宽度或者高度。

OnGlobalLayoutListener 是ViewTreeObserver的内部类，当一个视图树的布局发生改变时，可以被ViewTreeObserver监听到，这是一个注册监听视图树的观察者(observer)，在视图树的全局事件改变时得到通知。ViewTreeObserver不能直接实例化，而是通过getViewTreeObserver()获得。

除了OnGlobalLayoutListener ，ViewTreeObserver还有如下内部类：
interfaceViewTreeObserver.OnGlobalFocusChangeListener
当在一个视图树中的焦点状态发生改变时，所要调用的回调函数的接口类
interfaceViewTreeObserver.OnGlobalLayoutListener
当在一个视图树中全局布局发生改变或者视图树中的某个视图的可视状态发生改变时，所要调用的回调函数的接口类

* interfaceViewTreeObserver.OnPreDrawListener

当一个视图树将要绘制时，所要调用的回调函数的接口类

* interfaceViewTreeObserver.OnScrollChangedListener

当一个视图树中的一些组件发生滚动时，所要调用的回调函数的接口类

* interfaceViewTreeObserver.OnTouchModeChangeListener

当一个视图树的触摸模式发生改变时，所要调用的回调函数的接口类

### 利用OnGlobalLayoutListener来获得一个视图的真实高度。

``` java
private int mHeaderViewHeight; 
private View mHeaderView; 
  
..... 
  
mHeaderView.getViewTreeObserver().addOnGlobalLayoutListener( 
 new OnGlobalLayoutListener() { 
  @Override
  public void onGlobalLayout() { 
                                                          
   mHeaderViewHeight = mHeaderView.getHeight(); 
   mHeaderView.getViewTreeObserver() 
     .removeGlobalOnLayoutListener(this); 
  } 
});
```

>> 注意：但是需要注意的是OnGlobalLayoutListener可能会被多次触发，因此在得到了高度之后，要将OnGlobalLayoutListener注销掉。

### View post事件中获取

``` java
public class TestHeight extends Activity { 
 TextView tv; 
  
 @Override
 protected void onCreate(Bundle savedInstanceState) { 
  super.onCreate(savedInstanceState); 
  setContentView(R.layout.activity_activity_b); 
   tv = (TextView) findViewById(R.id.textView); 
  tv.post(new Runnable() { 
   @Override
   public void run() { 
    int height= tv.getHeight(); 
   } 
  }); 
 } 
} 
```

### 直接测量计算

```java
int intw=View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED); 
int inth=View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED); 
textView.measure(intw, inth); 
int intwidth = textView.getMeasuredWidth(); 
int intheight = textView.getMeasuredHeight();
```