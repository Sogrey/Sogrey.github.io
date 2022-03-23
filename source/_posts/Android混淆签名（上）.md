---
title: Android混淆签名(上)
date: 2017-01-13 16:31:07
author: Sogrey
tags: [android,apk混淆,签名]
categories: Android
---
> 代码混淆，是将计算机程序的代码转换成一种功能上等价，但是难于阅读和理解的形式的行为。代码混淆可以用于程序源代码，也可以用于程序编译而成的中间代码。执行代码混淆的程序被称作代码混淆器。目前已经存在许多种功能各异的代码混淆器。
>
> 代码混淆的主要目的是为了保护源代码，阻止反向工程。反向工程会带来许多问题，诸如知识产权泄露，程序弱点暴露易受攻击等。使用即时编译技术的语言，如Java、C#所编写的程序更容易受到反向工程的威胁。[1](http://blog.csdn.net/hongshan50/article/details/22746703)
>
> 签名移步[签名](https://sogrey.github.io/article/Android%E6%B7%B7%E6%B7%86%E7%AD%BE%E5%90%8D%EF%BC%88%E4%B8%8B%EF%BC%89/)

<!-- more -->

# 1 混淆
## 1.1 混淆介绍

首先先简单说一下什么是混淆和混淆的作用，其实这个搜索下可以找到一堆官方的说法等等，这里简单口语叙述一下，混淆就是把代码替换成a、b、c基本字母组成的代码，比如一个方法名为：function()，混淆后可能会被替换成a()。

混淆的好处：

* 代码混淆后阅读性降低，反编译后破译程序难度提高
* 混淆后字节数减少，减少了应用了体积

前者只能说有一点作用，后者则需要看代码的数量。

当然不能忽视混淆的缺点：混淆后，测试不充分可能导致某些功能不能使用

## 1.2 Eclipse混淆和Android Studio混淆
**Eclipse**

首先打开“project.properties”文件，然后在文件中添加一行：

	proguard.config=${sdk.dir}/tools/proguard/proguard-android.txt:proguard-project.txt

文件中之前就有一行，不过是被注释掉了。

在release打包时就会按照我们的配置进行混淆，注意，在我们平时的debug时是不会进行混淆的。

**Android Studio**

在build.gradle中进行配置

	android {
	    buildTypes {
	        release {
	            minifyEnabled true //true 表示开启混淆
	            proguardFiles getDefaultProguardFile（'proguard-android.txt'), 'proguard-rules.pro'
	            //proguardFile 'some-other-rules.txt'  配置单个文件这样
	        }
	    }
	}
## 1.3 混淆步骤

1. shrink： 去掉无用代码
2. optimize：优化代码（静态化，内联，无用参数去除等。。）
3. obfuscate：混淆，给类、变量、方法改名字
4. preverify：预效验

## 1.4 混淆规则
[混淆规则文档](https://stuff.mit.edu/afs/sipb/project/android/sdk/android-sdk-linux/tools/proguard/docs/index.html#manual/introduction.html)

**优化控制**

这个是用于控制混淆是否开启优化代码，例如一些if/else语句可以被简化等这些操作：

	# 不优化
	-dontoptimize 
	# 代码循环优化次数，0-7，默认为5
	-optimizationpasses 5

**优化进阶**

开启优化后可以设置下面的规则，assumenosideeffects表示指定的代码无效，可以优化，最终效果表现为不执行。	

	# 混淆时所采用的优化规则
	-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
	# 关闭log
	-assumenosideeffects class android.util.Log {
	    public static boolean isLoggable(java.lang.String, int);
	    public static int v(...);
	    public static int i(...);
	    public static int w(...);
	    public static int d(...);
	    public static int e(...);
	}

**基本混淆规则**

下面这些一般混淆规则都要加入，其中前两个在默认文件中已经配置

	# 包名不使用大小写混合 aA Aa
	-dontusemixedcaseclassnames 
	# 不混淆第三方引用的库
	-dontskipnonpubliclibraryclasses 
	# 不做预校验
	-dontpreverify 
	# 忽略警告
	-ignorewarning

**输出混淆记录**

混淆后由于阅读困难性提高，所以为了方便自己查阅，可以输出mapping对应文件，可以利用AndroidSDK\tools\proguard\bin中的proguardgui.bat打开混淆工具，利用retrace结合mapping和stacktrace调试遇到的错误

	# 混淆后生产映射文件 map 类名->转化后类名的映射
	# 存放在app\build\outputs\mapping\release中
	-verbose 
	# 混淆前后的映射
	-printmapping mapping.txt 
	# apk 包内所有 class 的内部结构
	-dump class_files.txt 
	# 未混淆的类和成员
	-printseeds seeds.txt 
	# 列出从 apk 中删除的代码
	-printusage unused.txt

**保留源代码行号**

即使使用retrace工具，还是很难定位到错误的时候，可以暂时先保留行号，观察错误修改后再关闭掉

	# 抛出异常时保留代码行号
	# 这个最后release的时候关闭掉
	-keepattributes SourceFile,LineNumberTable

**组件白名单">基本组件白名单**

Android中的基本组件不能混淆，为了方便，下面提供了兼容性比较高的规则：

	-keep public class * extends android.app.Fragment
	-keep public class * extends android.app.Activity
	-keep public class * extends android.app.Application
	-keep public class * extends android.app.Service
	-keep public class * extends android.content.BroadcastReceiver
	-keep public class * extends android.content.ContentProvider
	-keep public class * extends android.app.backup.BackupAgentHelper
	-keep public class * extends android.preference.Preference

**Support包规则**

	# 如果有引用v4包可以添加下面这行
	-keep public class * extends android.support.v4.app.Fragment
	 
	# 如果引用了v4或者v7包
	-dontwarn android.support.**

**不混淆本地方法**

本地方法不能混淆，这个规则在默认配置文件中有：

	# 保持 native 方法不被混淆
	-keepclasseswithmembernames class * {
	    native <methods>;
	}

**WebView混淆规则**

使用了WebView的JS功能则开启下面规则，这个规则在自定义规则文件中已经用注释说明了：

	# WebView使用javascript功能则需要开启
	-keepclassmembers class fqcn.of.javascript.interface.for.webview {
	    public *;
	}

**注解、泛型和反射混淆**

	# 保护注解
	-keepattributes *Annotation*
	-keep class * extends java.lang.annotation.Annotation {*;}
	 
	# 泛型与反射
	-keepattributes Signature
	-keepattributes EnclosingMethod</code>
有些注解可能不能被混淆，需要手动混淆一下

**内部类混淆**

	# 不混淆内部类
	-keepattributes InnerClasses</code>

**部分第三方混淆参考规则**

Gson

	# gson
	-dontwarn com.google.**
	-keep class com.google.gson.** {*;}

otto

	# otto混淆规则
	-keepattributes *Annotation*
	-keepclassmembers class ** {
	    @com.squareup.otto.Subscribe public *;
	    @com.squareup.otto.Produce public *;
	}

universal-image-loader

	-dontwarn com.nostra13.universalimageloader.**
	-keep class com.nostra13.universalimageloader.** {*;}

友盟统计

	# 友盟统计
	-keepclassmembers class * {
	    public <init> (org.json.JSONObject);
	}
	 
	# 友盟统计5.0.0以上SDK需要
	-keepclassmembers enum * {
	    public static **[] values();
	    public static ** valueOf(java.lang.String);
	}
	 
	# 友盟统计R.java删除问题
	-keep public class com.gdhbgh.activity.R$*{
	    public static final int *;
	}

OkHttp

	# OkHttp
	-dontwarn com.squareup.okhttp.**
	-keep class com.squareup.okhttp.** {*;}
	-keep interface com.squareup.okhttp.** {*;}
	-dontwarn okio.**</code>

nineoldandroids

	-dontwarn com.nineoldandroids.*
	-keep class com.nineoldandroids.** {*;}

支付宝

	# 支付宝
	-keep class com.alipay.android.app.IAlixPay{*;}
	-keep class com.alipay.android.app.IAlixPay$Stub{*;}
	-keep class com.alipay.android.app.IRemoteServiceCallback{*;}
	-keep class com.alipay.android.app.IRemoteServiceCallback$Stub{*;}
	-keep class com.alipay.sdk.app.PayTask{
	    public *;
	}
	-keep class com.alipay.sdk.app.AuthTask{
	    public *;
	}

Socket.io

	# socket.io
	-keep class socket.io-client.
	-keepclasseswithmembers,allowshrinking class socket.io-client.* {*;}
	-keep class io.socket.
	-keepclasseswithmembers,allowshrinking class io.socket.* {*;}

JPUSH

	# jpush
	-dontwarn cn.jpush.**
	-keep class cn.jpush.** {*;}
	 
	# protobuf（jpush依赖）
	-dontwarn com.google.**
	-keep class com.google.protobuf.** {*;}

友盟分享

这个只有部分热门的SDK，具体可以参考分享文档：

	# 友盟分享
	-dontwarn com.umeng.**
	-dontwarn com.tencent.weibo.sdk.**
	 
	-keep public interface com.tencent.**
	-keep public interface com.umeng.socialize.**
	-keep public interface com.umeng.socialize.sensor.**
	-keep public interface com.umeng.scrshot.**
	 
	-keep public class com.umeng.socialize.* {*;}
	 
	-keep class com.umeng.scrshot.**
	-keep public class com.tencent.** {*;}
	-keep class com.umeng.socialize.sensor.**
	-keep class com.umeng.socialize.handler.**
	-keep class com.umeng.socialize.handler.*
	-keep class com.tencent.mm.sdk.modelmsg.WXMediaMessage {*;}
	-keep class com.tencent.mm.sdk.modelmsg.** implements com.tencent.mm.sdk.modelmsg.WXMediaMessage$IMediaObject {*;}
	 
	-keep class im.yixin.sdk.api.YXMessage {*;}
	-keep class im.yixin.sdk.api.** implements im.yixin.sdk.api.YXMessage$YXMessageData{*;}
	 
	-keep class com.tencent.** {*;}
	-dontwarn com.tencent.**
	-keep public class com.umeng.soexample.R$*{
	    public static final int *;
	}
	-keep class com.tencent.open.TDialog$*
	-keep class com.tencent.open.TDialog$* {*;}
	-keep class com.tencent.open.PKDialog
	-keep class com.tencent.open.PKDialog {*;}
	-keep class com.tencent.open.PKDialog$*
	-keep class com.tencent.open.PKDialog$* {*;}
	 
	-keep class com.sina.** {*;}
	-dontwarn com.sina.**
	-keep class  com.alipay.share.sdk.** {*;}



## 1.5 混淆模板

参见[这里](https://github.com/Sogrey/notes/blob/master/%E6%B7%B7%E6%B7%86%E6%A8%A1%E6%9D%BF.md)

## 1.6 填混淆的坑

**网络层混淆**

混淆要注意，一般网络层都不进行混淆，可以经过划分包后直接不混淆网络层的包：

	-keep class com.xxx.xxx.http.** {*;}</code>

**数据模型混淆**

所有bean都不要混淆，可以使用下面的：

	-keep class * implements java.io.Serializable {*;}
	-keepclassmembers class * implements java.io.Serializable {*;}

但是有时候上述代码可能导致应用卡住，没用任何错误提示，所以我建议采用分包模式，把所有bean放在一个包中，直接对该包加白名单：

	-keep class com.xxx.xxx.domain.** {*;}

**XML映射问题**

如果你遇到一些控件无法Inflate，报NullPointException，比如ListView，NavigationView等等，这个问题花了我几个小时自己研究出了规则：

	-keep class org.xmlpull.v1.** {*;}

**混淆规则编写方法**

如果混淆后报错，通过retrace后找到错误的问题后可以直接编写规则来去掉混淆，但是如果报的错误莫名其妙，而且报错的类没有混淆，那么你可以采用极端的方法，加入下面规则：

	-keep class *.** {*;}

这条规则表示不混淆所有类及其中所有代码，加了这条规则之后，
还不能运行表示是其他问题，例如注解，内部类等等，
可以运行后，可以通过反编译，寻找所有包名，记录下来，把上述规则改为：

	-keep class android.** {*;}
	-keep class com.** {*;}
	-keep class io.** {*;}
	-keep class org.** {*;}
	...

一个个去掉检查是否有报错，例如查到

	-keep class com.** {*;}

加了就不报错，则可以继续一级级往下检查。

> 签名移步[签名](https://sogrey.github.io/article/Android%E6%B7%B7%E6%B7%86%E7%AD%BE%E5%90%8D%EF%BC%88%E4%B8%8B%EF%BC%89/)

# 参考
* [混淆规则文档](https://stuff.mit.edu/afs/sipb/project/android/sdk/android-sdk-linux/tools/proguard/docs/index.html#manual/introduction.html)
* [Android混淆心得](http://www.2cto.com/kf/201607/530170.html)
* [ProGuard代码混淆技术详解](http://www.cnblogs.com/cr330326/p/5534915.html)