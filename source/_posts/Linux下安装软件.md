---
title: Linux下安装软件
date: 2020-12-05 13:47:33
tags: [Linux,deb,rpm]
categories: Linux
comments: true
toc: true
---


linux系统下怎么安装软件？

- deb 是 ubuntu 、debian 的格式。
- rpm 是 redhat 、fedora 、suse 的格式。

<!--more-->

## 安装deb文件

deb是debian发行版的软件包，而ubuntu是基于debian 发行的所以可以用。

.deb是solaris系统下的安装包后缀名。安装方法如下：

1. `cd` 到安装包的目录
2. `dpkg -i 安装包名字` 如果权限不够，`sudo`来凑。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/安装deb.png)

## 安装rpm文件

如果你使用的是red hat linux，然后运行以下命令安装：

1. `cd` 到安装包的目录
2. `rpm -ivh 安装包名字`

## 安装tar.gz文件

有时，部分软件是以`.tar.gz`打包的，比如我要安装的java jdk:jdk-8u161-linux-x64.tar.gz

执行命令：`tar -zxvf jdk-8u161-linux-x64.tar.gz`

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/安装tar.png)


其中必要参数有如下：
- `-A` 新增压缩文件到已存在的压缩
- `-c` 建立新的压缩文件
- `-d` 记录文件的差别
- `-r` 添加文件到已经压缩的文件
- `-u` 添加改变了和现有的文件到已经存在的压缩文件
- `-x` 从压缩的文件中提取文件
- `-t` 显示压缩文件的内容
- `-z` 支持``gzip``解压文件
- `-j` 支持``bzip2``解压文件
- `-Z` 支持compress解压文件
- `-v` 显示操作过程
- `-l` 文件系统边界设置
- `-k` 保留原有文件不覆盖
- `-m` 保留文件不被覆盖
- `-W` 确认压缩文件的正确性


## 参考

- [Linux tar.gz、tar、bz2、zip 等解压缩、压缩命令详解](https://www.runoob.com/w3cnote/linux-tar-gz.html)
- [linux tar 解压命令总结](https://blog.csdn.net/imyang2007/article/details/7634470)
- [Linux：linux下解压*压缩tar.xz、tar、tar.gz、tar.bz2、tar.Z、rar、zip、war等文件方法](https://www.cnblogs.com/nhdlb/p/11568991.html)
- [wget命令](https://man.linuxde.net/wget)
