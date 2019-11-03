---
title: Android Studio开发组件化App遇到的问题
date: 2019-10-30 11:38:40
tags: [Android]
categories: Android
comments: true
toc: true
---

由于项目需求，需要开发组件化App，开发过程中遇到些问题，特此记录，以防再遇。



## Q1

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

|                                                              |      |      |
| ------------------------------------------------------------ | ---- | ---- |
| ![](https://raw.githubusercontent.com/Sogrey/GithubPagePics/master/imgs/Sync-Project-with-Gradle-Files-1.jpg) | ![](https://raw.githubusercontent.com/Sogrey/GithubPagePics/master/imgs/Sync-Project-with-Gradle-Files-2.jpg)     | ![](https://raw.githubusercontent.com/Sogrey/GithubPagePics/master/imgs/Sync-Project-with-Gradle-Files-3.jpg)     |



