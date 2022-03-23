---
title: 玩转Windows子系统Linux之准备工作
date: 2021-09-09 20:57:52
author: Sogrey
tags: [WSL,Windows,Linux]
categories: Linux
comments: true
toc: true
---

WSL 全称为 Windows Subsystem for Linux (Windows 下的 Linux 子系统)。是一个在Windows 10上能够运行原生Linux二进制可执行文件（ELF格式）的兼容层。 Windows 下的 Linux 子系统并不包含 Linux 内核, 所以这严格上讲并不是一个真正的 Linux 系统。

<!--more-->


## 操作环境

- Windows 10 专业版64位


## 准备工作

`开始` > `设置` > `应用`
![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl01.png)

点击 `程序和功能` 打开 程序和功能窗口。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl02.png)

点击 `启用或关闭Windows功能` 选中 `适用于Linux的Windows子系统`，点击确定，等待安装完成。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl03.png)

安装完成后需要重启计算机。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl04.png)

完成上面一系列操作，准备工作就做完了，现在去Windows10软件商店搜索`WSL`即可找到Linux。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl05.png)

