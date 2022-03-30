---
title: OpenEuler安装UKUI
author: Sogrey
date: 2021-09-28 21:15:03
tags: [Linux,OpenEuler,UKUI]
categories: Linux
comments: true
toc: true
---

9 月 23 日-25 日，华为全联接 2021 在线上举办。近日，华为在全联接大会上发布了全新操作系统“openEuler 欧拉”。openEuler 是一个开源、免费的 Linux 发行版平台，将通过开放的社区形式与全球的开发者共同构建软件生态体系。同时，openEuler 也是一个创新的平台，鼓励任何人在该平台上提出新想法、开拓新思路、实践新方案。

<!--more-->

- [openEuler官网](https://openeuler.org/) https://openeuler.org/

下载地址：https://openeuler.org/zh/mirror/list/

怀着对国产操作系统的支持，下载安装来体验一把。

安装过程其实也并不复杂，这里一笔带过。安装完成后重启看到下面界面：

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/imgs%2FopenEuler-01.png)

登入root账户:

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/imgs%2FopenEuler-02.png)

对于熟悉linux系统的资深linuxer,到这已经够用了。但对于我，命令行显然并不友好，下面安装GUI，GUI选择华为为OpenEuler研发的[UKUI](https://www.ukui.org/index.php?lang=cn)。

[UKUI官网](https://www.ukui.org/index.php?lang=cn)有文[UKUI for openEuler 发布！](https://www.ukui.org/news/shownews.php?id=96&lang=cn),文末记录了如何安装UKUI。

开始安装UKUI,可直接使用`yum install`安装：

``` bash
yum install ukui
```

期间需要输入几次`y`已确认安装。

安装字体库：

``` bash
yum groupinstall fonts -y
```

确认以上安装完成后，输入：

``` bash
systemctl set-default graphical.target
```
重启(`reboot`)之后即可启动图形界面。

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/imgs%2FopenEuler-03.png)

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/imgs%2FopenEuler-04.png)