---
title: 如何完全卸载AutoCAD
date: 2020-07-26 07:26:18
tags: [软件,AutoCAD]
author: Sogrey
categories: 软件
comments: true
toc: true
---

最近开发CAD图纸相关，卸载重装AutoCAD时遇装不上了，提示是已安装。这是因为上一次卸载后没有清理干净。

<!--more-->

## 如何完全卸载AutoCAD

先说明我的操作系统是 `window 10 专业版`，安装的CAD版本是 `AutoCAD 2020简体中文版`。

具体操作如下：

1、在电脑左下角，`开始（Windows）` > `设置` > `应用` > `应用和功能` 最下面找到`程序和功能` 点击打开 `卸载或更改程序` ，在控制面板中，找到**Autodesk**，一个一个的只要是能卸载的，都卸载掉。

![如何完全卸载cad](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/TIM-20200726081959.png)

2、打开桌面我的电脑，找到AUTOCAD安装的文件夹，删掉。一般是在C盘，或自己装的其它盘。都看看，找到删掉。

还有一个隐藏位置，在`C://ProgramData`下，都删了，这里包含你安装的CAD所有版本。

![如何完全卸载cad](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/TIM-20200726082227.png)

3、彻底删除CAD注册表

在电脑左下角，点开始，运行，输入`regedit`回车或点确定。

![如何完全卸载cad](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/TIM-20200726082331.png)

出现注册表，找到“HKEY_CURRENT_USER\software\”目录下的Autodesk文件夹，在Autodesk文件夹上右键，删除。

![如何完全卸载（删除）cad吗？](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/TIM-20200726082552.png)

找到“HKEY_LOCAL_MACHINE\software\”目录下的Autodesk文件夹，在Autodesk文件夹上右键，删掉。

![如何完全卸载（删除）cad吗？](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/TIM-20200726082659.png)

删除“HKEY_LOCAL_MACHINE\software\classes\installer\products”目录下的挨个找一遍，一般会出现开头和尾号一样的几条在一起，看右边是否有`AutoCAD`字样，有就删掉。

注：这里不同版本的CAD，products下的可能不一样，大家点开耐心看图二右侧处是不是CAD，是的话删除。

![如何完全卸载CAD](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/TIM-20200726082817.png)

再关闭注册表，现在再重装就能装上了。

## 安装异常

### 安装CAD时，提示1603错误

![安装CAD时，提示1603错误](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/autocad-error-1603.png)

1. 删除安装程序，找到一下路径`C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing`，然后以管理员身份运行duUNINSTALL.EXE程序，删除软件,重试。

2. 如果还存在以上问题，以管理员身份运行命令窗口，然后输入命令`C:\Program Files(x86)\Common Files\Autodesk Shared\AdskLicensing\Current\AdskLicensingService\AdskLicensingService.exe` 重新安装软件，再试，建议下载最新的安装包

### Cad 界面出现乱码

如图：

![CAD界面乱码](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/CAD界面乱码.png)

解决方案：

找到AutoCAD安装目录跟目下的Fonts文件夹，该文件夹存放的就是字体了，在该文件夹下找到simsun.ttc字体删除就好了。

![CAD界面乱码修复](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/CAD界面乱码修复.png)