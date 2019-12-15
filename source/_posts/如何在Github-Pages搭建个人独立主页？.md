---
title: 如何在Github Pages搭建个人独立主页？
date: 2017-01-09 09:58:38
tags: [Github pages,git]
toc: true
categories: HEXO博客
---

# 1准备工作

## 1.1 Github注册及使用。
官网是：[https://pages.github.com/](https://pages.github.com/)，是github提供的一个服务，我们可以免费的再其上面搭建自己的网站，也有很多人利用github pages作为自己的个人博客站点。GitHub Pages本用于介绍托管在GitHub的项目， 不过，由于他的空间免费稳定，用来做搭建一个博客再好不过了。
### 1.1.1 Github登录
登录地址：[https://github.com/login](https://github.com/login)，还没有github账号的小伙伴赶紧去注册一个，点击"[Create an account](https://github.com/join?source=login)"注册不再赘述。
![github登录](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/sogrey_github_20170109101825.png)

<!-- more -->

### 1.1.2 新建仓库
登录成功之后到[仓库信息填写界面](https://github.com/new)创建一个仓库,须注意仓库的名称必须是：`{你的用户名}.github.io`，将`{你的用户名}`换成你自己的名字，例如我自己的`Sogrey.github.io`
![新建github仓库](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_104430.png)
### 1.1.3 获取git地址
进入刚仓库点击`Clone or download`可查看git地址以备后用。
![获取git地址](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_104936.png)

## 1.2 安装准备软件
### 1.2.1 依次下载安装：
* [Node.js](http://nodejs.org/)
* [Git](http://git-scm.com/)（[Git for Windows 国内下载站](https://github.com/waylau/git-for-win)）

选择本地目录作为工作空间，我这里选择的是：`E:\github`,为方便演示我已另外创建了仓库：`Test.github.io`,git地址是：[https://github.com/Sogrey/Test.github.io.git](https://github.com/Sogrey/Test.github.io.git).

### 1.2.2 clone到本地
命令行进入硬盘上任意一个文件夹，我这里选择`E:\github`，然后执行

	git clone https://github.com/Sogrey/Test.github.io.git

![clone到本地](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_112759.png)
此时你会发现在`E:\github`目录下会多出文件，正是我们github上的文件目录
![clone到本地](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_113346.png)

![clone到本地](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_113812.png)

# 2 新建测试页面
## 2.1 新建测试页面文件
我们在clone下来的目录里新建一个html文档：`index.html`,必须.git文件夹在同一个目录,输入以下内容：

    <!DOCTYPE html>
    <html>
    	<head>
    		<title>Hello world</title>
    		<meta charset='utf-8'>
    	</head>
    	<body>
    		<h1>Hello world！这是我使用github pages搭建的个人站点。</h1>
    	</body>
    </html>

![新建测试页面](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_115202.png)

## 2.2 上传测试页面
命令行指定到clone下来的目录里

	cd Test.github.io

![命令行指定到clone下来的目录里](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_115619.png)
下面就是提交了，依次输入以下命令：

	git add .
	git commit -m "更新index.html，编写测试页面"
	git push
![git 提交](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_120645.png)
依次执行git add . , git commit -m "注释"，git push，然后输入你的用户名，密码即可。
在浏览器直接访问看看：
`http://{你的域名}.github.io`

由于这里我已经创建了`sogrey.github.io`,再次创建会作为`sogrey.github.io`的一个子目录：
![访问github pages](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_125632.png)
以上文字出现乱码，解决办法是另存`index.html`为`utf-8 无BOM` 格式
![访问github pages](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_130649.png)
注意：

* 如果是创建子目录，仓库名可以不按照 `{你的域名}.github.io`这种格式，直接自定义，比如把上面`Test.github.io`改成`Test`，直接访问[https://sogrey.github.io/Test/](https://sogrey.github.io/Test/)即可。
* 如果是创建子目录，默认不显示为github pages，设置方法为 `Settings` -> `GitHub Pages` -> `Source` 改为 `master branch` 点击 `Save`保存即可。
![创建github pages子目录设置](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_131707.png)
重新访问[https://sogrey.github.io/Test/](https://sogrey.github.io/Test/)试试：
![重新访问](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/2017-01-09_132154.png)

到此，一个简单的github pages就建好了。Good luck!

# 参考
* [如何利用github打造博客专属域名](http://blog.csdn.net/lmj623565791/article/details/51319147)
* [如何搭建一个独立博客——简明Github Pages与Hexo教程](http://www.jianshu.com/p/05289a4bc8b2)
* [Hexo搭建Github-Pages博客填坑教程](http://www.jianshu.com/p/35e197cb1273)
* [用Hexo创建个人博客](http://www.jianshu.com/p/b06222fbc135)

Markdown 语法参考：

* [Markdown 编辑器语法指南](https://segmentfault.com/markdown)
* [Markdown——入门指南](http://www.jianshu.com/p/1e402922ee32/)
* [Markdown 语法说明 (简体中文版)](http://www.appinn.com/markdown/)