---
title: Redis踩坑记
date: 2021-04-10 23:50:25
tags: [Redis,踩坑记]
categories: Redis
comments: true
toc: true
---

记录Redis开发中遇到的填坑经历。

<!--more-->

## 配置连接远程ip的Redis

1. 修改redis服务器的配置文件redis.windows.conf
注释绑定的主机地址
```
# bind 127.0.0.1
```
修改为远程连接的IP地址
```
bind 192.168.1.12
```
2. 在Redis根目录下，以管理员身份打开CMD命令窗口
输入`redis-server redis.windows.conf`，启动服务
3. 在Redis根目录下尝试远程连接并查看
```
redis-cli -h ip地址 -p 6379 能够连接
```
输入`info` 能够输出信息