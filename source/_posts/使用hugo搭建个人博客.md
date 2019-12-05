---
title: 使用hugo搭建个人博客
date: 2019-12-04 22:56:16
tags: [hugo]
categories: Hugo
comments: true
toc: true
---

之前使用[`Hexo`](https://hexo.io/)([`https://sogrey.github.io/`](https://sogrey.github.io/) [github](https://github.com/Sogrey/Sogrey.github.io))和[`jekyll`](http://jekyllcn.com/)(http://sogrey.gitee.io/ [github](https://gitee.com/Sogrey/Sogrey))搭建过个人博客，这次选择`Hugo`试试。

<!-- more -->

## Hugo

[Hugo](https://gohugo.io/) 是由 Go 语言实现的静态网站生成器。简单、易用、高效、易扩展、快速部署。

## 安装

windows:

推荐二进制安装（简单、快速）

到 [Hugo Releases](https://github.com/gohugoio/hugo/releases) 下载对应的操作系统版本的Hugo二进制文件（hugo或者`hugo.exe`）

Hugo Releases：[https://github.com/gohugoio/hugo/releases](https://github.com/gohugoio/hugo/releases)

我下载到`hugo_0.60.1_Windows-64bit.zip`，解压后进入文件夹，会看到一个`hugo.exe`文件，将`hugo.exe`所在的目录添加到系统环境变量PATH下面,使用`cmd`命令行执行:

``` bash
$ hugo version
Hugo Static Site Generator v0.60.1-96066756 windows/amd64 BuildDate: 2019-11-29T14:57:23Z
```

说明已配置成功。

mac:

``` bash
brew install hugo
hugo version
```

请自行验证。

## 创建站点和文章

### 创建站点

一行命令搞定：

``` bash
$ hugo new site HugoSite
Congratulations! Your new Hugo site is created in G:\workspace\github\sogrey\hugo\HugoSite.

Just a few more steps and you're ready to go:

1. Download a theme into the same-named folder.
   Choose a theme from https://themes.gohugo.io/ or
   create your own with the "hugo new theme <THEMENAME>" command.
2. Perhaps you want to add some content. You can add single files
   with "hugo new <SECTIONNAME>\<FILENAME>.<FORMAT>".
3. Start the built-in live server via "hugo server".

Visit https://gohugo.io/ for quickstart guide and full documentation.
```

站点就创建好了，目录结构如下：

``` 
HugoSite/
    archetypes/ 
    content/ 
    data/ 
    layouts/ 
    static/ 
    themes/
    config.toml
```

进入`HugoSite`目录，创建一篇文章吧。

### 创建文章

在站点目录下执行以下命令：

``` bash
$ hugo new HelloWorld.md
G:\workspace\github\sogrey\hugo\HugoSite\content\HelloWorld.md created
```

创建第一篇文章`HelloWorld`。

打开`HelloWorld.md`（该文件位于 `HugoSite/content/`目录下）文件进行编辑，我是用的编辑器是[typora](http://typora.io/)。

``` 
---
title: "HelloWorld"
date: 2019-12-04T23:39:58+08:00
tags = ["Hugo"]
---

# Hello World
```

> 
> 这里使用markdown来编写文章
> 

## 修改配置

修改配置文件config.toml：

``` toml
//默认为：
baseURL = "http://example.org/"
languageCode = "en-us"
title = "My New Hugo Site"
//修改为
baseURL = "github发布出去的博客地址"
languageCode = "en-us"
title = "My New Hugo Site"
publishDir = "publish"
```

修改了baseURL，并增加了publishDir。publishDir的修改是因为：当在content目录下添加了.md文件后，需要执行`hugo -t <主题名>`来用hugo把发布用的目录编译出来，而默认的编译目录名为`publish`。

## 安装主题

Hugo themes：https://themes.gohugo.io/

你可以到上面的网站中挑选你喜欢的主题。然后，根据指引找到`github`项目地址进行下载。

我这里选择[hyde](https://themes.gohugo.io/hyde/) ([github](https://github.com/spf13/hyde)),把主题通过git克隆或直接下载到本地。放到 `HugoSite/themes/`目录下,执行：

``` bash
$ cd themes/
$ git clone https://github.com/spf13/hyde.git
```

在“config.toml”文件中指定“hyde”作为默认主题。只需添加行:

``` toml
theme = "hyde"
```

配置主题`theme.toml`:

``` toml
name = "Sogrey's Hugo Site"
license = "MIT"
licenselink = "https://sogrey.github.io/about/mit.html"
description = "Sogrey's Hugo Site"
tags = ["blog", "hugo"]
features = ["blog", "themes", "disqus"]
min_version = 0.53

[author]
    name = "Sogrey"
    homepage = "https://sogrey.github.io"

# If Porting existing theme
[original]
    author =  "mdo"
    homepage = "http://markdotto.com/"
    repo = "https://www.github.com/mdo/hyde"
```


## 启动服务

执行：

``` bash
$ hugo server
Building sites …
                   | EN
+------------------+----+
  Pages            |  8
  Paginator pages  |  0
  Non-page files   |  0
  Static files     |  6
  Processed images |  0
  Aliases          |  0
  Sitemaps         |  1
  Cleaned          |  0

Built in 5 ms
Watching for changes in G:\workspace\github\sogrey\hugo\HugoSite\{archetypes,content,data,layouts,static,themes}
Watching for config changes in G:\workspace\github\sogrey\hugo\HugoSite\config.toml
Environment: "development"
Serving pages from memory
Running in Fast Render Mode. For full rebuilds on change: hugo server --disableFastRender
Web Server is available at http://localhost:1313/HugoSite/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

访问`http://localhost:1313/HugoSite/`

![](https://cdn.jsdelivr.net/gh/sogrey/cdn/imgs/sogrey-hugo-site.jpg)

站点就搭建好了。

## 上传部署到GitHub

在github上新建仓库，我这里命名为[`HugoSite`](https://github.com/Sogrey/HugoSite)。

执行：

``` bash
$ hugo -t hyde
Building sites …
                   | EN
+------------------+----+
  Pages            |  8
  Paginator pages  |  0
  Non-page files   |  0
  Static files     |  6
  Processed images |  0
  Aliases          |  0
  Sitemaps         |  1
  Cleaned          |  0

Total in 43 ms
```

多了`publish`,就是用于存放编译后的站点文件。

### 推送github

我习惯将源码推送`master`主分支，站点发布在`gh-pages`分支，已提供好[`deploy.sh`](https://github.com/Sogrey/HugoSite/blob/master/deploy.sh)，修改其中的github地址为你自己的地址，尽情使用吧！

``` bash
#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

echo -e "\033[32;40m [1/3] \033[0m commit 2 master branch"
echo -e ""
git init
git add -A
git commit -m 'deploy master'

# 如果你想要部署到 https://USERNAME.github.io
git push -f https://github.com/Sogrey/HugoSite.git master
echo -e ""
echo -e "\033[32;40m [2/3] \033[0m Building static files"
echo -e ""
# 生成静态文件
hugo -t hyde

echo -e ""
echo -e "\033[32;40m [3/3] \033[0m commit 2 gh-pages branch"
echo -e ""
# 进入生成的文件夹
cd publish

# 如果是发布到自定义域名
# echo 'www.yourwebsite.com' > CNAME

git init
git add -A
git commit -m 'deploy gh-pages(web site)'

git push -f https://github.com/Sogrey/HugoSite.git master:gh-pages

cd -
```
执行如下：
``` bash
$ bash deploy.sh


  ____        U  ___ u    ____      ____     U _____ u   __   __
 / __"| u      \/"_ \/ U /"___|u U |  _"\ u  \| ___"|/   \ \ / /
<\___ \/       | | | | \| |  _ /  \| |_) |/   |  _|"      \ V /
 u___) |   .-,_| |_| |  | |_| |    |  _ <     | |___     U_|"|_u
 |____/>>   \_)-\___/    \____|    |_| \_\    |_____|      |_|
  )(  (__)       \\      _)(|_     //   \\_   <<   >>  .-,//|(_
 (__)           (__)    (__)__)   (__)  (__) (__) (__)  \_) (__)  .github.io


 [1/3]  commit 2 master branch

Reinitialized existing Git repository in G:/workspace/github/sogrey/hugo/HugoSite/.git/
warning: LF will be replaced by CRLF in content/HelloWorld.md.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in publish/categories/index.xml.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in publish/helloworld/index.html.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in publish/index.xml.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in publish/sitemap.xml.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in publish/tags/index.xml.
The file will have its original line endings in your working directory
[master 60c0113] deploy master
 1 file changed, 1 insertion(+), 1 deletion(-)
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (4/4), 435 bytes | 435.00 KiB/s, done.
Total 4 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/Sogrey/HugoSite.git
   bd0c5f8..60c0113  master -> master

 [2/3]  Building static files

Building sites …
                   | EN
+------------------+----+
  Pages            |  8
  Paginator pages  |  0
  Non-page files   |  0
  Static files     |  6
  Processed images |  0
  Aliases          |  0
  Sitemaps         |  1
  Cleaned          |  0

Total in 40 ms

 [3/3]  commit 2 gh-pages branch

Reinitialized existing Git repository in G:/workspace/github/sogrey/hugo/HugoSite/publish/.git/
warning: LF will be replaced by CRLF in categories/index.xml.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in helloworld/index.html.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in index.xml.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in sitemap.xml.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in tags/index.xml.
The file will have its original line endings in your working directory
[master bfe7070] deploy gh-pages(web site)
 3 files changed, 3 insertions(+), 3 deletions(-)
Enumerating objects: 11, done.
Counting objects: 100% (11/11), done.
Delta compression using up to 8 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (6/6), 697 bytes | 697.00 KiB/s, done.
Total 6 (delta 4), reused 0 (delta 0)
remote: Resolving deltas: 100% (4/4), completed with 4 local objects.
To https://github.com/Sogrey/HugoSite.git
   ef3e33a..bfe7070  master -> gh-pages
/g/workspace/github/sogrey/hugo/HugoSite
```

访问发布后的[站点](https://sogrey.github.io/HugoSite/);