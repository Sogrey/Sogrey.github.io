---
title: Hexo 添加 Gitment 评论
date: 2018-03-11 22:53:19
tags: [Hexo,Gitment]
categories: Gitment
comments: true
toc: true
---

由于之前使用的多说停用了，不得不另找其他评论插件就看到了 Gitment,源码在这 [github](https://github.com/imsun/gitment)。

话不多说，直接开整。

<!-- more -->

## 1 注册Gitment OAuth Application

[官方介绍](https://imsun.net/posts/gitment-introduction/)

[点击此处](https://github.com/settings/applications/new) 来注册一个新的 OAuth Application。其他内容可以随意填写，但要确保填入正确的 callback URL（一般是评论页面对应的域名，比如我的就是 `https://sogrey.github.io/`）。

![注册Gitment OAuth Application](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/注册Gitment OAuth Application.png)

你会得到一个 client ID 和一个 client secret，这个将被用于之后的用户登录。

![Gitment ClientId](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/Gitment ClientId.png)

后面如果想查找之前注册的Gitment ClientId，在GitHub点击`Settings`>`Developer settings` 即[developers](https://github.com/settings/developers)

![查找Gitment ClientId](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/查找Gitment ClientId.png)

![查找Gitment ClientId](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/查找Gitment ClientId2.png)

## 2 安装Gitment插件

如果你希望引用确定版本的 Gitment，则应该使用 npm 进行安装。

	$ npm install --save gitment

关于构造函数中的更多可用参数请查看 [Gitment Options](https://github.com/imsun/gitment#options)


## 3 引入 Gitment 到 hexo 文章页面

我的主题是 `yelog` 是基于 `yelee` 的，其他主题也可参考。

将下面代码添加到文章页面,我贴在 `themes\yelog\layout\_partial\article.ejs` 的末尾：

``` html
<!--gitment 评论-->
  <div class="comments" id="comments">
  
	<!--汉化-->
    <link rel="stylesheet" href="https://billts.site/extra_css/gitment.css">
	<script src="https://billts.site/js/gitment.js"></script>
	<!--原型-->
	<!--
	<link rel="stylesheet" href="https://imsun.github.io/gitment/style/default.css">
	<script src="https://imsun.github.io/gitment/dist/gitment.browser.js" type="text/javascript"></script>
	-->
	
      <div id="gitmentContainer" style="margin-bottom: -19px;"></div>
     
      <style>
        .gitment-container a {
          border: none;
        }
        .comments {
          margin: 60px 0 0;padding: 0 60px;
        }
      </style>
     
      <script type="text/javascript">
        var gitment = new Gitment({
			  id: '<%= page.title %>',
			  title: '<%= page.title %>',
			  owner: 'Sogrey',
			  repo: 'Sogrey.github.io',
			  oauth: {
				client_id: '5826******a208c',
				client_secret: '95db82**************************d7f6be1',
			  },
        })
        gitment.render('gitmentContainer')
      </script>
    
  </div>
<!--gitment 评论 end-->
```

其中：

* id: '<%= page.title %>',//页面标题作为issue的label,长度不超过50，否则会出现 Error：validation failed 错误提示
* owner 你的GitHub用户名即可
* repo 保存评论的GitHub仓库名
* client_id 你注册的Gitment Client ID [可在[developers](https://github.com/settings/developers)找到你注册的Gitment查看]
* client_secret 你注册的Gitment Client secret [可在[developers](https://github.com/settings/developers)找到你注册的Gitment查看]
* 汉化来自[评论框汉化问题](https://github.com/imsun/gitment/issues/104)

## 4 主题配置

在主题的 `_config.yml`文件添加（各参数解释如上）：

	# Gitment
	# Introduction: https://imsun.net/posts/gitment-introduction/
	gitment:
	  enable: true
	  githubID: Sogrey
	  repo: Sogrey.github.io
	  ClientID: 5826******a208c
	  ClientSecret: 95db82**************************d7f6be1
	  lazy: false

其中：

* lazy: false true表示评论懒加载，即不直接显示评论，false则直接显示评论，懒加载可参考[hexo next主题集成gitment评论系统](http://blog.csdn.net/yanzi1225627/article/details/77890414)配置 `gitmentbutton` 的显示文字。

## 5 部署网站

依次执行：

	hexo g
	hexo d

查看站点。

## 6 初始化评论

页面发布后，你需要访问页面并使用你的 GitHub 账号登录（请确保你的账号是第一步所填 repo 的 owner），点击初始化按钮。

只有你自己先初始化后在会在对应的GitHub 仓库的issue中创建一条对应的issue，之后其他用户即可在该页面发表评论。


## Gitment坑点小结 部分出自[iHTCboy](https://www.jianshu.com/p/57afa4844aaa)

**1 `owner: 'Your GitHub ID'`**

	owner: '你的 GitHub ID',
	可以是你的GitHub用户名，也可以是github id，建议直接用GitHub用户名就可以。

**2 `repo: 'The repo to store comments`**

	repo: '存储评论的 github repo'
	这个是你要存储评论内容的仓库名，可以与博客下的仓库，也可以新建一个仓库专门存储评论内容的。

**3 `Error: Not Found问题`**

	owner或者repo配置错误了，注意名字和仓库名字的大小写。

**4 `Error: Comments Not Initialized`**

	在注册OAuth Application这个步骤中，给Authorization callback URL指定的地址错了
	还没有在该页面的Gitment评论区登陆GitHub账号

如果还是不行，可以参考另一个情况 [Error: Comments Not Initialized · Issue #95 · imsun/gitment](https://link.jianshu.com/?t=https%3A%2F%2Fgithub.com%2Fimsun%2Fgitment%2Fissues%2F95)

**5 `Error：validation failed`**

	issue的标签label有长度限制！labels的最大长度限制是50个字符。
	id: '页面 ID', // 可选。默认为 location.href
	这个id的作用，就是针对一个文章有唯一的标识来判断这篇本章。
	在issues里面，可以发现是根据网页标题来新建issues的，然后每个issues有两个labels（标签），一个是gitment，另一个就是id。
	所以明白了原理后，就是因为id太长，导致初始化失败，现在就是要让id保证在50个字符内。
	
	对应配置的id为：
	
	id: '<%= page.title %>'
	如果用网页标题也不能保证在50个字符！
	
	最后，我用文章的时间，这样长度是保证在50个字符内，完美解决！（避免了文章每次更新标题或路径时，会重新创建一个issue评论的问题。）
	
	id: '<%= page.date %>'
**5-1 `Error：validation failed` 另一种**

刚新建了一篇文章，初始化评论时控制台报错：

```
Failed to load resource: the server responded with a status of 422 (Unprocessable Entity)
```

因为我使用文章名作为label，查错过程就不细说了，并不是上面第五点的原因，这个原因太坑了，就是因为我新建文章标题中包含英文半角的`,`开始确定是因为label的问题，在排除50字符限制之后，实在无法，就直接新建label，提示无效，惊呆了我都，尝试更换标点符号为中文`，`这次成功新建label。然后修改文章名，重新提交成功初始化。特此记录。

**6 gitment的汉化**

	只需到模板里将原来定义CSS和JS的那两行改成：
	
	<link rel="stylesheet" href="https://billts.site/extra_css/gitment.css">
	<script src="https://billts.site/js/gitment.js"></script>
	即可。来源：https://github.com/imsun/gitment/issues/104

**7 Gitment出现在文章列表上**

![Gitment出现在文章列表上](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/Gitment出现在文章列表上.png)

解决办法是为上面添加在文章页面上的那一大段代码 添加 下面代码将其包裹在内：

``` html
	<% if (!index) { %>
    <!--原来的代码-->
	<% } %>
```

即变成下面的样子

``` html
	<!--gitment 评论-->
	<% if (!index) { %>
	  <div class="comments" id="comments">
	  
		<!--汉化-->
	    <link rel="stylesheet" href="https://billts.site/extra_css/gitment.css">
		<script src="https://billts.site/js/gitment.js"></script>
		<!--原型-->
		<!--
		<link rel="stylesheet" href="https://imsun.github.io/gitment/style/default.css">
		<script src="https://imsun.github.io/gitment/dist/gitment.browser.js" type="text/javascript"></script>
		-->
		
	      <div id="gitmentContainer" style="margin-bottom: -19px;"></div>
	     
	      <style>
	        .gitment-container a {
	          border: none;
	        }
	        .comments {
	          margin: 60px 0 0;padding: 0 60px;
	        }
	      </style>
	     
	      <script type="text/javascript">
	        var gitment = new Gitment({
				  id: '<%= page.title %>',
				  title: '<%= page.title %>',
				  owner: 'Sogrey',
				  repo: 'Sogrey.github.io',
				  oauth: {
					client_id: '5826******a208c',
					client_secret: '95db82**************************d7f6be1',
				  },
	        })
	        gitment.render('gitmentContainer')
	      </script>
	    
	  </div>
	<% } %>
	<!--gitment 评论 end-->
```

**8 Error: Bad credentials**

此类错误一般原因是填写授权`Client ID`或`Client Secret`时有误，请确认是否正确，我这里出现，之前是好的，因换了系统重新配置提交后就这样了。F12 查看到gitment.js 有两个 401.定位应该是授权问题。

[Error: Bad credentials#145](https://github.com/imsun/gitment/issues/145)

![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/Error%20Bad%20credentials.jpg)

解决：

我在[Settings](https://github.com/settings/profile)/[Developer settings](https://github.com/settings/developers)的`OAuth Apps`中找到我们授权的应用，重新生产秘钥，重新配置就好了。
![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/OAuth%20Apps.jpg)
![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/OAuth%20Apps2.jpg)
重新配置 theme 下的 _config.yml 文件
![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/gitment_config.jpg)

**9 绑定了新域名后评论系统登录异常**

最近刚刚申请了一个`.top`域名，用来解析本站[`sogtey.github.io`](https://sogrey.github.io) -> [`https://sogrey.top/`](https://sogrey.top/)。由此也引来一些问题，不是什么大问题，就是我们的域名变了，而我们在GitHub的[`Developers srttings`](https://github.com/settings/developers) `OAuth Apps`里注册的还是`sogrey.github.io`。这就导致评论系统无法登陆，因为`Authorization callback URL`已经不匹配了。

解决方案：

将`Homepage URL`以及`Authorization callback URL`改为我们新域名地址（[`https://sogrey.top/`](https://sogrey.top/)）即可。

记得点击`Update application`按钮保存更新。