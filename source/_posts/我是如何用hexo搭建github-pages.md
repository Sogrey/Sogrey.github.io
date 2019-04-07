---
title: 我是如何用hexo搭建github pages
date: 2017-01-08 20:53:05
tags: [HEXO,Github pages]
categories: HEXO博客
---

# 1 准备
首先简单描述一下搭建的大体准备工作：

* 1 拥有一个 github pages
* 2 本地环境  Git 和 Node.js
* 3 在本地电脑里配置 hexo 的环境。（ hexo 与 github pages 绑定，写博文修改博文等，生成静态博客并 push to github 。)
* 4 绑定自己的域名（也可以不用绑定，需要绑定的自行百度。）

本节要讲的是 如何用hexo搭建github pages,对于第1、2两点可参考另一篇[如何在Github-Pages搭建个人独立主页？](https://sogrey.github.io/article/%E5%A6%82%E4%BD%95%E5%9C%A8Github-Pages%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E7%8B%AC%E7%AB%8B%E4%B8%BB%E9%A1%B5%EF%BC%9F/)

<!-- more -->

# 2 Hexo 
Hexo 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。
## 2.1 Hexo 安装
官网：[https://hexo.io/](https://hexo.io/)

安装流程参考[官方文档](https://hexo.io/zh-cn/docs/)，避免入坑。
## 2.2 Hexo 建站
Hexo 安装好了之后，就开始进行建站。cmd打开终端 cd 到指定目录（这里使用D盘根目录`d:\`）并使用如下命令即可建好

	hexo init yourname 
	cd yourname 
	npm install

其中 yourname 是你的文件夹名字可随意取（本文章假设 yourname 的文件夹名称是 Hexo ）。
或直接新建Hexo，在`D:\HEXO`使用git Bash命令执行亦可,直接在此目录下`右键` 选择`git Bash`,依次执行以下命令：

	hexo init
	npm install

![git Bash命令](https://sogrey.github.io/pics/2017-01-09_151319.png)
![git Bash命令](https://sogrey.github.io/pics/2017-01-09_161000.jpg)
完成之后会在D盘会创建一个Hexo目录
![Hexo目录](https://sogrey.github.io/pics/2017-01-09_161345.jpg)
建站可参考[建站|Hexo](https://hexo.io/zh-cn/docs/setup.html)

**特别提示：如何与 Github pages 进行关联:**

在刚刚创建出来的目录的根目录下存在一个 `_config.yml` 文件,使用文本编辑器打开，在最末尾配置：

	deploy:
	  type: git
	  repository: https://github.com/Sogrey/Sogrey.github.io.git
	  branch: master

其中 `repository` 字段的值替换成你的 github pages 提交代码的git地址,git地址如何获取参见[如何在Github-Pages搭建个人独立主页？](https://sogrey.github.io/article/%E5%A6%82%E4%BD%95%E5%9C%A8Github-Pages%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E7%8B%AC%E7%AB%8B%E4%B8%BB%E9%A1%B5%EF%BC%9F/)中`1.1.3 获取git地址`

## 2.3 Hexo 本地发布
使用终端命令进行发布：

	hexo clean
	hexo g #作用同 hexo generate
	hexo s #作用同 hexo server
![Hexo 本地发布](https://sogrey.github.io/pics/2017-01-09_161613.jpg)
命令详解，`hexo clean`是清除缓存，`hexo g`是生成本地发布文件夹，`hexo s`启动本地服务并发布，发布成功之后浏览器查看[http://localhost:4000/](http://localhost:4000/)
![Hexo 本地发布](https://sogrey.github.io/pics/2017-01-09_161808.jpg)

如需停止本地服务，命令行按 `ctrl+c`

Hexo 命令参考[官方文档](https://hexo.io/zh-cn/docs/commands.html)

## 2.4 Hexo 发布到github pages
当然这存在于本地，而并未发布到github pages服务器，所以需要使用终端命令进行发布：

	hexo clean
	hexo g #作用同 hexo generate
	hexo d #作用同 hexo deploy

命令详解，`hexo clean`是清除缓存，`hexo g`是生成本地发布文件夹，`hexo d`才是最后的发布到 github pages 上，期间会依次弹出两个输入框，依次输入你的github用户名和密码。更多的 hexo 命令操作请参考官方文档即可。不过一般用来用去无非就是创建页面、发布这么几条命令而已。

> 最后提示一点，可能会遇到的问题，在执行`hexo init`时，若提示
>
> SSL certificate problem: unable to get local issuer certificate
>
> 可以 先执行`git config --global http.sslVerfiy false` 
    

到此，就可以到github pages去查看上传的页面了。Good lock!

# 参考
* [我的博客是如何搭建的（github pages + HEXO + 域名绑定）](http://www.tuicool.com/articles/MramqqJ)
* [HEXO+Github,搭建属于自己的博客](http://www.jianshu.com/p/465830080ea9)
* [手把手教你使用Hexo + Github Pages搭建个人独立博客](https://segmentfault.com/a/1190000004947261)
* [如何搭建一个独立博客——简明Github Pages与Hexo教程](http://www.jianshu.com/p/05289a4bc8b2)
* [使用hexo搭建github.io博客(一)](http://www.cnblogs.com/liulangmao/p/4323064.html)