---
title: Android Studio开发组件化App遇到的问题
date: 2019-10-30 11:38:40
tags: [Android]
categories: Android
comments: true
toc: true
---

由于项目需求，需要开发组件化App，开发过程中遇到些问题，特此记录，以防再遇。



## Q1 Compilation is not supported for following modules

> Compilation is not supported for following modules: module1, module2, module3. Unfortunately you can't have non-Gradle Java modules and Android-Gradle modules in one project.

提示以上信息，当然其中的`module1, module2, module3`是我举例，实际会报告项目中的`mudule`的名字。

### Solution 1

Then you should go to `File` -> `Invalidate Caches / Restart` -> `Invalidate Caches & Restart`.

Then try to build the application again.

### Solution 2

Click on the button:`Sync Project with Gradle Files`

### Solution 3 (helpful for me)

1- close the project

2- close `Android Studio` IDE

3- delete the `.idea` directory

4- delete all `.iml` files

5- open `Android Studio` IDE and import the project

<!-- more -->

|                                                              |      |      |
| ------------------------------------------------------------ | ---- | ---- |
| ![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/Sync-Project-with-Gradle-Files-1.jpg) | ![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/Sync-Project-with-Gradle-Files-2.jpg)     | ![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/Sync-Project-with-Gradle-Files-3.jpg)     |

## Q2  依赖重复问题

一般组件化项目会有一个`baselibrary`的基础依赖库，基础组件中的依赖jar包,不能使用`implementation`,要使用`api`,比如Gson:

``` gradle
api 'com.google.code.gson:gson:2.8.2'
```

## Q3  运行后手机上出现多个icon


所有可能成为library的组件,都要改集成运行时的清单文件,否则还是会出问题

参考[这里](https://blog.csdn.net/u010899138/article/details/53516400)

## Q4 依赖库版本号统一

参考[这里](https://blog.csdn.net/gao_chun/article/details/58105089)

## Q5 多个ModuleApplication共存问题

> Execution failed for task `:app:processDebugManifest`.
> Manifest merger failed : Attribute application@name value=(com.baseres.BaseApplication) from AndroidManifest.xml:8:9-51
>    is also present at [:carcomponent] AndroidManifest.xml:14:9-55 value=(com.carcomponent.CarApplication).
>    Suggestion: add `tools:replace="android:name"` to `<application>` element at AndroidManifest.xml:7:5-24:19 to override.

自定义 Application 需要声明在 AndroidManifest.xml 中。其次，每个 Module 都有该清单文件，但是最终的 APK 文件只能包含一个。因此，在构建应用时，Gradle 构建会将所有清单文件合并到一个封装到 APK 的清单文件中。

合并的优先级是:

`App Module` > `Library Module`

参考[这里](https://www.jianshu.com/p/5ccc545596d4)