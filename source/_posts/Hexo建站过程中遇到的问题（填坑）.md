---
title: Hexo建站过程中遇到的问题（填坑篇）
categories: Hexo建站填坑
date: 2017-08-12 17:34:17
tags: [Hexo建站填坑,手记]
---

> 在此收集Hexo建站过程中遇到的问题（填坑）

1 执行 `hexo d` 报 `ERROR Deployer not found: git`

![](https://sogrey.github.io/GithubPagePics/imgs/hexo_d_not_fount_git.png)

解决方法： 执行 `npm install hexo-deployer-git --save`

2 local search 失效（换电脑后）

更换电脑后，源文件打包拷过来，却发现本地搜索失效：

![](https://sogrey.github.io/GithubPagePics/imgs/本地搜索失效.png)

解决方法： 重新安装 search 插件 [github](https://github.com/PaicHyperionDev/hexo-generator-search)

执行 `npm install hexo-generator-search --save`

![](https://sogrey.github.io/GithubPagePics/imgs/hexo-generator-search.png)

重新编译发布正常：

![](https://sogrey.github.io/GithubPagePics/imgs/本地搜索正常.png)


*会持续更新...*