---
title: 下载神器 you-get
date: 2019-03-14 14:44:22
tags: [you-get,下载]
categories: you-get
comments: true
toc: true
---

在windows 上：

## 1 安装

1. 从[https://github.com/soimort/you-get/releases/latest](https://github.com/soimort/you-get/releases/latest)下载，解压后在cmd中切换至目录下执行you-get即可

2. 安装python,执行 
  ``` bash
  $ pip3 install you-get #安装
  $ pip3 install --upgrade you-get #更新
  $ pip3 install --upgrade git+https://github.com/soimort/you-get@develop #更新
  ```

  [https://you-get.org/ ](https://you-get.org/ )

  [github](https://github.com/soimort/you-get )
  
  <div class="github-widget" data-repo="soimort/you-get"></div>
  <script type="text/javascript" src="https://git.hust.cc/GitHub-Repo-Widget.js/GithubRepoWidget.js"></script>

  下载ffmpeg从[ffmpeg.org](http://www.ffmpeg.org/)并添加到PATH 

3. 即可在任意目录下使用you-get 



## 2 用法 

``` bash
Usage: you-get [OPTION]... [URL]...

Startup options:
    -V | --version                      版本信息
    -h | --help                         帮助
    
Dry-run options: (no actual downloading)
    -i | --info                         列出所有可获取的视频信息
    -u | --url                          打印URLs的提取出信息，真实链接地址
         --json                         打印URLs的JSON格式
    
Download options:
    -n | --no-merge                     不合并分片
         --no-caption                   不下载其他文件（字幕，歌词，弹幕。。。）
    -f | --force                        覆盖存在的文件
    -F | --format <STREAM_ID>           选择下载那种清晰度的视频
    -O | --output-filename <FILE>       设置输出文件名
    -o | --output-dir <PATH>            输出文件夹（相对位置可用，如：~/video/）
    -p | --player <PLAYER [OPTIONS]>    将提取出的真实地址传给播放器
    -c | --cookies <COOKIES_FILE>       导入cookies.txt或cookies.sqlite（firefox下使用export-cookies插件）
    -x | --http-proxy <HOST:PORT>       使用HTTP代理下载
    -y | --extractor-proxy <HOST:PORT>  仅对真实地址视频文件的下载使用HTTP代理
         --no-proxy                     不使用代理
    -s | --socks-proxy <HOST:PORT>      使用SOCKS5协议代理
    -t | --timeout <SECONDS>            设置代理的timeout
    -d | --debug                        显示traceback和其他的debug信息
    -I | --input-file                   仅下载链接的视频不下载列表
```

## 3 注意 


默认情况下，下载最高清晰度视频
输入任意内容如：you-get "i love china" 可以从Google内搜索并下载视频，youtube-dl也有类似功能
bug地址：https://github.com/soimort/you-get/issues
-c和-p参数非常好用

