---
title: Activity启动模式(lauchMode)
date: 2018-12-22 13:59:21
author: Sogrey
tags: [Android,Activity]
categories: Android
comments: true
toc: true
---

launchMode在多个Activity跳转的过程中扮演着重要的角色，它可以决定是否生成新的Activity实例，是否重用已存在的Activity实例，是否和其他Activity实例公用一个task里。这里简单介绍一下task的概念，task是一个具有栈结构的对象，一个task可以管理多个Activity，启动一个应用，也就创建一个与之对应的task。

<!-- more -->

Activity一共有以下四种launchMode：

1.standard

2.singleTop

3.singleTask

4.singleInstance

我们可以在AndroidManifest.xml配置<activity>的android:launchMode属性为以上四种之一即可。

下面我们结合实例一一介绍这四种lanchMode：

**1.standard**  **标准模式**

standard模式是默认的启动模式，不用为<activity>配置android:launchMode属性即可，当然也可以指定值为standard。



**说明：** Android创建Activity时的默认模式，假设没有为Activity设置启动模式的话，默觉得标准模式。每次启动一个Activity都会又一次创建一个新的实例入栈，无论这个实例是否存在。



**生命周期：**如上所看到的，每次被创建的实例Activity 的生命周期符合典型情况，它的onCreate、onStart、onResume都会被调用。

**举例：**此时Activity 栈中以此有A、B、C三个Activity，此时C处于栈顶，启动模式为**Standard 模式**。



**简单点理解：standard启动模式Activity栈从栈底到栈顶顺序为A1 -> B -> C -> A2...。（其中A、B、C等都表示不同的Activity实例，A1、A2则表示属于具有同一Activity类的不同实例）**

 

**2.singleTop**  **栈顶复用模式**

我们在上面的基础上为<activity>指定属性android:launchMode="singleTop"，系统就会按照singleTop启动模式处理跳转行为。



**说明：**分两种处理情况：须要创建的Activity已经处于栈顶时，此时会直接复用栈顶的Activity。不会再创建新的Activity；若须要创建的Activity不处于栈顶，此时会又一次创建一个新的Activity入栈，同Standard模式一样。

**生命周期：**若情况一中栈顶的Activity被直接复用时，它的onCreate、onStart不会被系统调用，由于它并没有发生改变。可是一个新的方法 **onNewIntent**会被回调（Activity被正常创建时不会回调此方法）。

**举例：**此时Activity 栈中以此有A、B、C三个Activity，此时C处于栈顶，启动模式为**SingleTop 模式**。情况一：在C Activity中加入点击事件，须要跳转到还有一个同类型的C Activity。

结果是直接复用栈顶的C Activity。

情况二：在C Activity中加入点击事件，须要跳转到还有一个A Activity。结果是创建一个新的Activity入栈。成为栈顶。



**这就是singleTop启动模式，如果发现有对应的Activity实例正位于栈顶，则重复利用，不再生成新的实例。**

**简单点理解，singleTop即表示当前Activity栈中“栈顶唯一”，Activity跳转顺序或standard模式下栈结构如果为：A -> B -> C -> D1 -> D2，则singleTop启动模式为：A -> B -> C -> D1(此时回调D1的onNewIntent()..)。**

 

**3.singleTask**  **栈内复用模式**

**说明：**若须要创建的Activity已经处于栈中时，此时不会创建新的Activity，而是将存在栈中的Activity上面的其他Activity所有销毁，使它成为栈顶。

**生命周期：**同SingleTop 模式中的情况一同样。仅仅会又一次回调Activity中的 **onNewIntent**方法

**举例：**此时Activity 栈中以此有A、B、C三个Activity。此时C处于栈顶，启动模式为**SingleTask 模式**。

情况一：在C Activity中加入点击事件，须要跳转到还有一个同类型的C Activity。结果是直接用栈顶的C Activity。情况二：在C Activity中加入点击事件，须要跳转到还有一个A Activity。

结果是将A Activity上面的B、C所有销毁，使A Activity成为栈顶。 

在上面的基础上我们修改FirstActivity的属性android:launchMode="singleTask"。



**这就是singleTask模式，如果发现所在Activity栈中有对应的Activity实例，则使此Activity实例之上的其他Activity实例统统出栈，使此Activity实例成为栈顶对象，显示到幕前。**

**简单点理解，singleTask表示当前Activity栈中“实例唯一”，Activity跳转顺序或standard模式下栈结构如果为：A -> B1 -> C -> D -> B2，则singleTask启动模式为：A -> B1(此时回调onNewIntent()..)**

 

**4.singleInstance**  **单实例模式**

**说明：** SingleInstance比較特殊，是全局单例模式，是一种加强的SingleTask模式。它除了具有它所有特性外，还加强了一点：具有此模式的Activity仅仅能单独位于一个任务栈中。

这个经常使用于系统中的应用，比如Launch、锁屏键的应用等等，整个系统中仅仅有一个！所以在我们的应用中一般不会用到。了解就可以。

**举例：**比方 A Activity是该模式，启动A后。系统会为它创建一个单独的任务栈，由于栈内复用的特性。兴许的请求均不会创建新的Activity，除非这个独特的任务栈被系统销毁。

这种启动模式比较特殊，因为它会启用一个新的栈结构，将Acitvity放置于这个新的栈结构中，并保证不再有其他Activity实例进入。





**简单点理解，singleInstance所标识的Activity，当被启动时，系统会首先判断系统其他栈中是否已经存在此Activity实例，有则直接使用，并且其所在的Activity栈理论上只有它一个Activity元素。所以启动它的Activity与它并不在一个task中，所以才需要特别注意Back的问题。一般表示为：task1 A -> task2 B。**

**singleInstance表示该Activity在系统范围内“实例唯一”。由此我们发现，singInstance和singleTask主要区别在与系统范围内的“实例唯一”还是当前Activity栈“实例唯一”。**





# **二.启动模式的使用方式**

## **1. 在 Manifest.xml中指定Activity启动模式**

一种静态的指定方法，在Manifest.xml文件里声明Activity的同一时候指定它的启动模式，这样在代码中跳转时会依照指定的模式来创建Activity。样例例如以下：

```
        <activity android:name="..activity.MultiportActivity" android:launchMode="singleTask"/>
```

## **2. 启动Activity时。在Intent中指定启动模式去创建Activity**

一种动态的启动模式，在new 一个Intent后，通过Intent的addFlags方法去动态指定一个启动模式。样例例如以下：

```
        Intent intent = new Intent();
        intent.setClass(context, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
```

------

**注意：**以上两种方式都能够为Activity指定启动模式，可是二者还是有差别的。



**（1）优先级**：动态指定方式即另外一种比第一种优先级要**高**，若两者同一时候存在，以另外一种方式为准。


**（2）限定范围**：第一种方式无法为Activity直接指定 **FLAG_ACTIVITY_CLEAR_TOP** 标识，另外一种方式无法为Activity指定 **singleInstance** 模式。



------

------

------

------

# **三. Activity 的 Flags**

标记位既能够设定Activity的启动模式，如同上面介绍的，在动态指定启动模式，比方 **FLAG_ACTIVITY_NEW_TASK** 和 **FLAG_ACTIVITY_SINGLE_TOP** 等。它还能够影响Activity 的运行状态 ，比方 **FLAG_ACTIVITY_CLEAN_TOP** 和 **FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS** 等。

以下介绍几个基本的标记位，切勿死记，理解几个就可以，须要时再查官方文档。

### **1. FLAG_ACTIVITY_NEW_TASK**

作用是为Activity指定 “**SingleTask**”启动模式。跟在AndroidMainfest.xml指定效果同样。

------

### **2. FLAG_ACTIVITY_SINGLE_TOP**

作用是为Activity指定 “**SingleTop**”启动模式，跟在AndroidMainfest.xml指定效果同样。

------

### **3. FLAG_ACTIVITY_CLEAN_TOP**

具有此标记位的Activity，启动时会将与该Activity在同一任务栈的其他Activity出栈。一般与SingleTask启动模式一起出现。它会完毕SingleTask的作用。但事实上SingleTask启动模式默认具有此标记位的作用

------

### **4.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS**

具有此标记位的Activity不会出如今历史Activity的列表中，使用场景：当某些情况下我们不希望用户通过历史列表回到Activity时，此标记位便体现了它的效果。它等同于在xml中指定Activity的属性：

```
android:excludeFromRecents="trure"
```

------

------

------

------

# **四. 启动模式的实际应用场景**

这四种模式中的Standard模式是最普通的一种，没有什么特别注意。而SingleInstance模式是整个系统的单例模式，在我们的应用中一般不会应用到。所以，这里就具体解说 **SingleTop** 和 **SingleTask**模式的运用场景：

## **1. SingleTask模式的运用场景**

最常见的应用场景就是保持我们应用开启后仅仅有一个Activity的实例。最典型的样例就是应用中展示的主页（Home页）。

假设用户在主页跳转到其他页面，运行多次操作后想返回到主页，假设不使用SingleTask模式，在点击返回的过程中会多次看到主页，这明显就是设计不合理了。



------

------

------

## **2. SingleTop模式的运用场景**

假设你在当前的Activity中又要启动同类型的Activity，此时建议将此类型Activity的启动模式指定为SingleTop，能够降低Activity的创建，节省内存！



------

------

------

## **3. 注意：复用Activity时的生命周期回调**

这里还须要考虑一个**Activity跳转时携带页面參数的问题**。

由于当一个Activity设置了SingleTop或者SingleTask模式后，跳转此Activity出现**复用原有Activity**的情况时，**此Activity的onCreate方法将不会再次运行。onCreate方法仅仅会在第一次创建Activity时被运行。**

而一般onCreate方法中会进行该页面的数据初始化、UI初始化，假设页面的展示数据无关页面跳转传递的參数，则不必操心此问题，若页面展示的数据就是通过getInten() 方法来获取，那么问题就会出现：getInten()获取的一直都是老数据，根本无法接收跳转时传送的新数据！