---
title: 提高国内访问GitHub的速度
date: 2021-03-16 23:26:16
author: Sogrey
tags: [Github,科学上网]
categories: 科学上网
comments: true
toc: true
---

因为某些原因，github访问速度确实太慢,于是就出现了很多提高github访问速度的方案。在此记录几种。

<!--more-->


## GitHub 镜像访问

这里提供两个最常用的镜像地址：

- [https://github.com.cnpmjs.org](https://github.com.cnpmjs.org)
- [https://hub.fastgit.org](https://hub.fastgit.org)

也就是说上面的镜像就是一个克隆版的 GitHub，你可以访问上面的镜像网站，网站的内容跟 GitHub 是完整同步的镜像，然后在这个网站里面进行下载克隆等操作。

> 不要在克隆站上登录你的github账号

## GitHub 文件加速
利用 Cloudflare Workers 对 github release 、archive 以及项目文件进行加速，部署无需服务器且自带CDN.

- [https://gh.api.99988866.xyz](https://gh.api.99988866.xyz)
- [https://g.ioiox.com](https://g.ioiox.com)

以上网站为演示站点，如无法打开可以查看开源项目：[gh-proxy-GitHub](https://hunsh.net/archives/23/) 文件加速自行部署。

## Github 加速下载
只需要复制当前 GitHub 地址粘贴到输入框中就可以代理加速下载！

地址：[http://toolwa.com/github/](http://toolwa.com/github/)

## 加速你的 Github

[https://github.zhlh6.cn](https://github.zhlh6.cn)

输入 Github 仓库地址，使用生成的地址进行 git ssh 等操作


## GitHub raw 加速
GitHub raw 域名并非 `github.com` 而是 `raw.githubusercontent.com`，上方的 GitHub 加速如果不能加速这个域名，那么可以使用 Static CDN 提供的反代服务。

将 `raw.githubusercontent.com` 替换为 `raw.staticdn.net` 即可加速。

## GitHub + Jsdelivr
jsdelivr 唯一美中不足的就是它不能获取 exe 文件以及 Release 处附加的 exe 和 dmg 文件。

也就是说如果 exe 文件是附加在 Release 处但是没有在 code 里面的话是无法获取的。所以只能当作静态文件 cdn 用途，而不能作为 Release 加速下载的用途。

## 通过 Gitee 中转 fork 仓库下载
网上有很多相关的教程，就是将github的仓库克隆同步到gitee上

## 通过修改 HOSTS 文件进行加速
手动把cdn和ip地址绑定。

- 获取 github 的 `global.ssl.fastly` 地址访问：[http://github.global.ssl.fastly.net.ipaddress.com/#ipinfo](http://github.global.ssl.fastly.net.ipaddress.com/#ipinfo) 获取cdn和ip域名：

得到：199.232.69.194 https://github.global.ssl.fastly.net

- 获取github.com地址

访问：[https://github.com.ipaddress.com/#ipinfo](https://github.com.ipaddress.com/#ipinfo) 获取cdn和ip：

得到：140.82.114.4 http://github.com

- 修改 host 文件映射上面查找到的 IP

windows系统：

  - 修改C:WindowsSystem32driversetchosts文件的权限，指定可写入：右击->hosts->属性->安全->编辑->点击Users->在Users的权限“写入”后面打勾。然后点击确定。
  - 右击->hosts->打开方式->选定记事本（或者你喜欢的编辑器）->在末尾处添加以下内容：
    ``` 
    199.232.69.194 github.global.ssl.fastly.net
    140.82.114.4 github.com
    ```

## 参考

- [提高国内访问 GitHub 的速度的 9 种方案](https://mp.weixin.qq.com/s/xc7wvTDcM4kTS_qILIlg2w)

