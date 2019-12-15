---
title: 使用 npm 安装 gitbook
date: 2019-02-14 09:50:14
tags: [node.js,npm,gitbook]
categories: Gitbook
comments: true
toc: true
---

近期项目中写接口API使用了gitbook，现特意记录下以便以后查阅。

<!--more-->

## 本地通过`npm`安装`Gitbook`命令行工具

安装 `node.js`就不说了，去[官网](https://nodejs.org/en/download/)找到对应平台安装包安装即可。

安装好`node.js`，在终端命令行中执行下面命令：

``` bash
$ npm install gitbook-cli -g
```

其中 [gitbook-cli](https://www.npmjs.com/package/gitbook-cli) 是 gitbook 的一个命令行工具, 通过它可以在电脑上安装和管理 gitbook 的多个版本. 

有时会因为权限不足报错，可提升权限安装：

``` bash
$ sudo npm install gitbook-cli -g
```

安装完毕，是的，安装结束了。

检查一下是否安装成功,执行：

``` bash
gitbook -V
```

查看当前安装的gitbook版本，此命令会默认同时安装 GitBook，正常输出则安装成功。

## Gitbook创建及使用

###  初始化

打开指定目录，执行：

``` bash
$ gitbook init
```

会自动生成两个必要的文件 README.md 和 SUMMARY.md。 

* **README.md**: 书的介绍文字，如前言、简介，在章节中也可做为章节的简介。
* **SUMMARY.md**: 定制书籍的章节结构和顺序。

> README.md 和 SUMMARY.md 是 GitBook 制作电子书的必要文件，可用 gitbook init 命令自动生成。 

## 编辑书籍目录

GitBook 使用 `SUMMARY.md` 文件作为书籍的目录结构，可以用来制作书籍目录。

使用缩进表示目录层级结构。

编辑`SUMMARY.md`:

``` markdown
# Summary

* [Introduction](README.md)
* [Part I](part1/README.md)
    * [Writing is nice](part1/writing.md)
    * [GitBook is nice](part1/gitbook.md)
* [Part II](part2/README.md)
    * [We love feedback](part2/feedback_please.md)
    * [Better tools for authors](part2/better_tools.md)
```

> 记得编辑完保存后执行 `gitbook init`来自动生成md文件。

### 预览

执行命令 gitbook serve ，会在当前目录生成一个`_book`的目录，gitbook 会启动一个 4000 端口用于预览。

``` bash
$ gitbook serve
```

你可以你的浏览器中打开这个网址： [http://localhost:4000](http://localhost:4000/) 预览电子书效果。 

### 发布

执行

``` bash
$ gitbook build
```

会在书籍的文件夹中生成一个 _book 文件夹, 里面的内容即为生成的 html 文件. 我们可以使用下面命令来生成网页而不开启服务器。 



到此一个简单的book就建好了。为了更好的体验可以配置需要的插件，请自行百度，配置不是必需的。



### 遇到的问题

#### Error: ENOENT: no such file or directory

``` bash
Error: ENOENT: no such file or directory, stat 'E:\workspace\引擎\3DEngine华为编辑器API\_book\gitbook\gitbook-plugin-fontsettings\fontsettings.js'
```

报错如上，解决办法可尝试修改文件：`C:\Users\{用户名}\.gitbook\versions\{版本号}\lib\output\website\copyPluginAssets.js`的112行（我的版本是`3.2.3`）:

![1553164553736](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/1553164553736.png)

注释掉 

``` js
confirm: true
```

或改为：

``` js
 confirm: false
```

