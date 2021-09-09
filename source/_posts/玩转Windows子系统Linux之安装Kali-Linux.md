---
title: 玩转Windows子系统Linux之安装Kali Linux
date: 2021-09-09 21:29:58
tags: [WSL,Windows,Linux]
categories: Linux
comments: true
toc: true
---


准备工作可阅读前一篇[玩转Windows子系统Linux之准备工作](http://sogrey.top/article/玩转Windows子系统Linux之准备工作/)

## 操作环境

- 主系统 ： Windows 10 专业版64位 [需要开启：开发者模式和Windows功能（适用于Linux的Windows子系统）]
- 子系统 ： Kali Linux

<!--more-->

## 安装Kali Linux子系统

准备工作完成后，在 Windows 10 的软件商店中搜索`WSL`找到`Kali Linux`,点击 “获取” 之后系统会自动下载安装, 安装完成后会出现"启动"按钮。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl06.png)

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl07.png)

点击“启动”，第一次正常启动子系统时会开始安装，安装完成之后会要求设置系统用户名和用户密码，用户名最好用小写英文，密码不要忘记，后面要用到。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl08.png)

至此, 子系统就安装完成了。类似的步骤也可以安装其他Linux，比如 Ubuntu Linux 。

## Win10子系统kali linux安装图形化界面

按`Ctrl+D`退出登录，并打开Windows命令行（`WIN+R` 输入`CMD`）输入如下命令:

``` bash
kali config --default-user root

net stop LxssManager
net start LxssManager
```

从`开始`找到刚安装的`Kali Linux`打开就默认位`root`用户了。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl09.png)

修改密码：

``` bash
┌──(root💀DESKTOP-10KKBKG)-[~]
└─# passwd root
New password:
Retype new password:
passwd: password updated successfully
```

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl10.png)



### 换中科大Kali源

习惯的先备份原文件：

``` bash
┌──(root💀DESKTOP-10KKBKG)-[~]
└─# mv /etc/apt/sources.list /etc/apt/sources.list.bak
```



创建新的`/etc/apt/sources.list`输入以下内容:

``` bash
deb https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
deb-src https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
```

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl11.png)

输入完以上内容 按`Ctrl+X` 退出，提示是否保存 ，按键`Y`确认保存。

执行以下命令update一下：

``` bash
┌──(root💀DESKTOP-10KKBKG)-[~]
└─# apt-get update
```

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl12.png)

### 安装图形界面

依次执行以下命令:

``` bash
┌──(root💀DESKTOP-10KKBKG)-[~]
└─# apt-get install kali-desktop-xfce
```

需要输入`Y(es)`,一会儿出现下面界面，选择第一项就好，按`↑↓`键移动到第一项点击空格选中，点击`Tab`键切换到`OK`按钮回车确认。后面就是漫长等待...

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl13.png)

``` bash
┌──(root💀DESKTOP-10KKBKG)-[~]
└─# apt-get install xorg

┌──(root💀DESKTOP-10KKBKG)-[~]
└─# apt-get install xfce4

┌──(root💀DESKTOP-10KKBKG)-[~]
└─# apt-get install xrdp
```



```bash
sudo sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini
sudo echo xfce4-session > ~/.xsession
sudo service xrdp restart
```

接着`win+R`打开运行栏，输入`cmd`，输入命令`ipconfig`查看自己`ip`。注意你用的网线就是以太网适配器ipv4，用的无线就是无线局域网适配器WLAN下的ipv4。

再次`win+R`打开运行栏，输入`mstsc`，打开远程桌面，输入自己的ip地址`xxx.xxx.xxx.xxx:3390`，点击连接，打开远程连接对话框。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl14.png)

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl15.png)

输入上面第一步时添加的用户和密码登录，或者后面我们修改过密码的root用户登录。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/wsl16.png)

进入到kali的图形化界面。

