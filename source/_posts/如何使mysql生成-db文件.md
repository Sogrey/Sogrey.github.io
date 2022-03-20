---
title: 如何使mysql生成.db文件
date: 2022-03-20 12:52:01
tags: [Mysql,sqlite]
categories: Mysql
comments: true
toc: true
---

## 1. 下载sqllite数据库

在本机中安装sqlite数据库。下载地址为（[http://www.sqlite.org/download.html](http://www.sqlite.org/download.html)）。加载完成后解压并添加到环境变量`path`中，`cmd`输入`sqlite3`，会有提示SQLite version等等的提示，表示安装成功；

``` cmd
Microsoft Windows [版本 10.0.19043.1586]
(c) Microsoft Corporation。保留所有权利。

C:\Users\Administrator>sqlite3
SQLite version 3.38.1 2022-03-12 13:37:29
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite>
```

## 2. 创建准备装载数据的sqlite数据库（xxx.db）

进入指定文件夹，在此文件夹中运行`cmd`，输入命令`sqlite3 chinese-idiom.db`回车，然后输入`.database`，就会自动创建一个数据库（chinese-idiom.db）；
```cmd
C:\Users\Administrator\Documents\dumps\Chinese-idiom>sqlite3 chinese-idiom.db
SQLite version 3.38.1 2022-03-12 13:37:29
Enter ".help" for usage hints.
sqlite> .database
main: C:\Users\Administrator\Documents\dumps\Chinese-idiom\chinese-idiom.db r/w
sqlite>
```

## 3. 使用navicat连接sqlite数据库

点击`连接`，选中`sqlite`，连接名填写`chinese-idiom.db`，选择‘现有数据库文件’，选中数据库（chinese-idiom.db）的路径，连接测试。

## 4. 使用navicat把mysql数据传输数据到chinese-idiom.db中

用navicat连接mysql数据库，选中需要转移的数据库，右键选择`数据传输`。`常规`选项中的`源`，就是准备转移的数据源mysql。`目标`就是sqlite数据库，选中`chinese-idiom.db`，选中一个数据库（main）,然后点击开始传输。

