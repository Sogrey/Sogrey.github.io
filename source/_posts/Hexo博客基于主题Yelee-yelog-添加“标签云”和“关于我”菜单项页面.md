---
title: Hexo博客基于主题Yelee(yelog) 添加“标签云”和“关于我”菜单项页面
date: 2017-01-11 17:00:30
tags: [HEXO,Yelee,yelog,“标签云”,“关于我”]
categories: HEXO博客
---

> * [如何在Github Pages搭建个人独立主页？](https://sogrey.github.io/article/%E5%A6%82%E4%BD%95%E5%9C%A8Github-Pages%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E7%8B%AC%E7%AB%8B%E4%B8%BB%E9%A1%B5%EF%BC%9F/)
> * [我是如何用hexo搭建github pages](https://sogrey.github.io/article/%E6%88%91%E6%98%AF%E5%A6%82%E4%BD%95%E7%94%A8hexo%E6%90%AD%E5%BB%BAgithub-pages/)
> 
> 经过前两篇我已经搭建好了一个简单的HEXO博客，目前使用的是主题是`yelog`,`yelog`是基于`yelee`修改而来，在页面的左半边是博主的信息，中间部分有个菜单，依次是`主页`、`所有文章`、`标签云`和`关于我`，博客搭建起来的时候`主页`和`所有文章`已经生效可以直接使用了，至于`标签云`和`关于我`这两个页面还并未创建，这节就来创建它们。

![yelog Menu](https://sogrey.github.io/GithubPagePics/imgs/2017-01-11_171158.jpg)

<!-- more -->

# 1 设置主题配置文件

在主题配置文件`themes\yelog\_config.yml`里找到`menu`,如下：

	# Header | 主菜单
	## About Page: `hexo new page about`
	## Tags Cloud Page: `hexo new page tags`
	menu:
	  主页: /
	  所有文章: /archives/
	  #随笔: /tags/随笔
	  标签云: /tags/
	  关于我: /about/
	  更新日志: /logs/

注：配置文件里用`#`注释

参照上面配置可以增删修改菜单项，比`标签云: /tags/`,表示有个菜单名为`标签云`,如文章开头的图，冒号后面的`/tags/`表示它的访问路径，比如我的站点是`https://sogrey.github.io/`,那么点击`标签云`菜单访问的是`https://sogrey.github.io/tags/`.

看到上面的配置中已经为我们写好的提示如何创建`标签云`和`关于我`页面:

	## About Page: `hexo new page about`
	## Tags Cloud Page: `hexo new page tags`

下面我来创建`标签云`页面。
# 2 创建`标签云`页面
在Hexo博客本地根目录右键选择`Git Bash`（前提是已安装好`Git`和`Node.js`,可参照[如何在Github Pages搭建个人独立主页？](https://sogrey.github.io/article/%E5%A6%82%E4%BD%95%E5%9C%A8Github-Pages%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E7%8B%AC%E7%AB%8B%E4%B8%BB%E9%A1%B5%EF%BC%9F/)）,输入命令：

	hexo new page tags

回车，提示：

	INFO  Created: ...\source\tags\index.md
就创建完成了。在`source\`目录下会多出一个`tags`文件夹，里面有一个`index.md`文件，打开该文件输入如下：

	---
	title: 标签云
	date: 2017-01-10 22:54:00
	type: "tags"
	comments: true
	---
其中：`title`和`date`是标题和创建时间，`type`表示类型，值`tags`表示这是个标签云页面，`comments`是是否允许评论，`true`表示允许评论。

这样标签云页面已经创建好了，部署试一下：

![标签云页面](https://sogrey.github.io/GithubPagePics/imgs/2017-01-11_180103.jpg)

# 3 创建`关于我`页面
创建`关于我`页面和`标签云`页面步骤一样；输入命令：

	hexo new page about
创建`about\index.md`文件，页面内容由你随意输入：

	---
	title: 关于我
	date: 2017-01-10 22:20:12
	---
	# 关于我
	
	=== 在此输入正文 ===

部署，预览页面：

![关于我](https://sogrey.github.io/GithubPagePics/imgs/2017-01-11_180604.jpg)

到此两个页面都已创建完成，可以发布到github或coding了。另外我自己添加了[更新日志](https://sogrey.github.io/logs/)页面，有兴趣的也可以自己创建一个，方法与上面创建`关于我`一样。

对于yelee主题的使用和配置，可参照[这里](http://moxfive.coding.me/yelee)。
Good luck!