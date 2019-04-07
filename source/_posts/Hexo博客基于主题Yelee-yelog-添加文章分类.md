---
title: Hexo博客基于主题Yelee(yelog) 添加文章分类
date: 2017-01-12 10:22:08
tags: [HEXO,Yelee,yelog,文章分类]
categories: HEXO博客
---

> [Hexo博客基于主题Yelee(yelog) 添加“标签云”和“关于我”菜单项页面](https://sogrey.github.io/article/Hexo%E5%8D%9A%E5%AE%A2%E5%9F%BA%E4%BA%8E%E4%B8%BB%E9%A2%98Yelee-yelog-%E6%B7%BB%E5%8A%A0%E2%80%9C%E6%A0%87%E7%AD%BE%E4%BA%91%E2%80%9D%E5%92%8C%E2%80%9C%E5%85%B3%E4%BA%8E%E6%88%91%E2%80%9D%E8%8F%9C%E5%8D%95%E9%A1%B9%E9%A1%B5%E9%9D%A2/)
> 
> 经过上一节，我已经添加了“标签云”和“关于我”等页面，但是回到标签云页面，我们看到页面上显示`已有0个分类，共计10个标签`，那么这个文章分类该怎么添加?这就是这节要讲的，也算是对上一篇的补充。
> ![标签云页面](https://sogrey.github.io/pics/2017-01-11_180103.jpg)

<!-- more -->

# 1 站点配置

在站点根目录下的`_config.yml`里有这么一段：

	# Directory
	source_dir: source
	public_dir: public
	tag_dir: tags
	archive_dir: archives
	category_dir: categories
	code_dir: downloads/code
	i18n_dir: :lang
	skip_render:

其中：`category_dir: categories`就是分配分类目录了，没有的可以按这样配置，下面就是创建了。

# 2 创建分类

跟创建`云标签`一样：

	hexo new page categories

在`source`目录下生成一个`categories\index.md`文件，编辑它：

	---
	date: 2017-01-12 02:23:17
	title: categories
	type: "categories"
	comments: false
	---

在上一篇说道`type`值为`tags`是标签云，这里是分类`categories`。就这么简单不用再做其他输入。

# 3 为文章添加分类

以[Hexo博客基于主题Yelee(yelog) 添加“标签云”和“关于我”菜单项页面](https://sogrey.github.io/article/Hexo%E5%8D%9A%E5%AE%A2%E5%9F%BA%E4%BA%8E%E4%B8%BB%E9%A2%98Yelee-yelog-%E6%B7%BB%E5%8A%A0%E2%80%9C%E6%A0%87%E7%AD%BE%E4%BA%91%E2%80%9D%E5%92%8C%E2%80%9C%E5%85%B3%E4%BA%8E%E6%88%91%E2%80%9D%E8%8F%9C%E5%8D%95%E9%A1%B9%E9%A1%B5%E9%9D%A2/)这一篇为例：

	---
	title: Hexo博客基于主题Yelee(yelog) 添加“标签云”和“关于我”菜单项页面
	date: 2017-01-11 17:00:30
	tags: [HEXO,Yelee,yelog,“标签云”,“关于我”]
	categories: HEXO博客
	---

其中：`categories: HEXO博客`就是设置该文章分类到`HEXO博客`。

> 注：文章标签可以添加多个，分类却只能有一个，设置多个只有第一个生效。

此时文章列表上就多了文章分类了，也可以再到`标签云`页面查看：
![分类](https://sogrey.github.io/pics/2017-01-12_110538.jpg)

Good luck!