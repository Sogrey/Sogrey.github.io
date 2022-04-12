---
title: 记录使用clash_for_windows订阅实现科学上网
date: 2022-04-10 09:46:22
author: Sogrey
tags: [科学上网]
categories: 科学上网
comments: true
toc: true
---

知乎上偶然看到一个《linux系统永久免费科学上网》（[原视频在此](https://www.zhihu.com/zvideo/1496121708049965056)），我们做开发，也会遇到查询一些资料被墙的无助，赶紧来试试。

<!--more-->

## 1. 准备
- Windows 10 专业版
- clash_for_windows v0.19.15 [github](https://github.com/Fndroid/clash_for_windows_pkg)

## 2. 下载安装clash_for_windows

可到[releases](https://github.com/Fndroid/clash_for_windows_pkg/releases)找到最新版本，根据你自己的设备选择安装。

## 3. 订阅

打开[https://v2rayse.com/](https://v2rayse.com/)找到第一项点击【进入】。

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-01.png)

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-02.png)

进入后访问需要输入密码，密码可通过电报、油管直播来获取 [「Telegram」](https://t.me/changfengshare) [「YouTube」](https://www.youtube.com/channel/UC-q1OwxWpoX4Ywou47xWM_w) 来获取，BUT,这两个网站都在外域，我是访问不了，在此被劝退了，有可以访问的朋友可以跟着文头视频继续。

但幸好站长在下方评论给出了他的网站可以拿到免费节点数据，而且是每天更新，地址是[https://cfmem.com](https://cfmem.com)。进入网站找到最新日期文章进入拉到最下面找到**订阅链接**中**clash订阅链接**，复制下来。

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-03.png)

打开刚安装的clash_for_windows,点击左侧菜单**Profiles**,输入框中填入刚复制的订阅地址，点击**Download**，等待下载完成即可，如果长时间下载不成，可通过浏览器或下载工具下载，文件拖入clash_for_windows也行。

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-04.png)

点击[General]按照如图打开相应开关，如果需要局域网支持打开**Allow LAN**开关。

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-05.png)

原视频最后还提到需要设置代理，`127.0.0.1` 端口: `7890`。勾选`System Proxy`即可。试试效果吧。

访问[https://www.youtube.com/](https://www.youtube.com/)真的可以打开了，视频播放也很流畅。

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-06.png)

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-07.png)

![](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/%E8%AE%B0%E5%BD%95%E4%BD%BF%E7%94%A8clash_for_windows%E8%AE%A2%E9%98%85%E5%AE%9E%E7%8E%B0%E7%A7%91%E5%AD%A6%E4%B8%8A%E7%BD%91-08.png)

## 4. 警告

《计算机信息网络国际联网管理暂行规定》第六条、第十四条：

    第六条 计算机信息网络直接进行国际联网，必须使用邮电部国家公用电信网提供的国际出入口信道。
    任何单位和个人不得自行建立或者使用其他信道进行国际联网。

    第十四条 违反本规定第六条、第八条和第十条的规定的，由公安机关责令停止联网，给予警告，可以并处 15000 元以下的罚款；有违法所得的，没收违法所得。

《计算机信息网络国际联网安全保护管理办法》第五条、第二十条进行处罚。因为多数翻墙者会浏览色情、赌博、暴力、危害国家安全等违法内容。

    第五条
    任何单位和个人不得利用国际联网制作、复制、查阅和传播下列信息:
    (一)煽动抗拒、破坏宪法和法律、行政法规实施的；
    (二)煽动颠覆国家政权，推翻社会主义制度的；
    (三)煽动分裂国家、破坏国家统一的；
    (四)煽动民族仇恨、民族歧视，破坏民族团结的；
    (五)捏造或者歪曲事实，散布谣言，扰乱社会秩序的；
    (六)宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖，教唆犯罪的；
    (七)公然侮辱他人或者捏造事实诽谤他人的；
    (八)损害国家机关信誉的；
    (九)其他违反宪法和法律、行政法规的。

    第二十条 违反法律、行政法规，有本办法第五条、第六条所列行为之一的，由公安机关给予警告，有违法所得的，没收违法所得，对个人可以并处五千元以下的罚款，对单位可以并处一万五千元以下的罚款。

如确因正常的工作、学习需要，可以在采取规范的信息安全技术措施情况下，偶尔翻墙，但是绝对不能向他人提供翻墙软件、账号，更不能发表、传播危害国家安全等非法内容。

珍惜资源，请勿用于从事非法活动。