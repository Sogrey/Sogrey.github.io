---
title: Linux上安装部署nginx
date: 2021-12-02 21:17:24
tags: [Linux,nginx]
categories: Linux
comments: true
toc: true
---

## 1 安装依赖包

安装Nginx需要依赖下面几个包：
1. `gzip` 模块需要 `zlib` 库 ( 下载: [http://www.zlib.net/](http://www.zlib.net/) )
2. `rewrite` 模块需要 `pcre` 库 ( 下载: [http://www.pcre.org/](http://www.pcre.org/) )
3. `ssl` 功能需要 `openssl` 库 ( 下载: [http://www.openssl.org/](http://www.openssl.org/) )

依赖包安装顺序依次为:openssl、zlib、pcre, 然后安装Nginx包

在线安装执行以下命令：

``` bash
yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel
```

## 2 下载Nginx并解压安装包

``` bash
cd /usr/local 
mkdir nginx # 创建一个文件夹
cd nginx
wget http://nginx.org/download/nginx-1.13.7.tar.gz # 下载tar包
tar -xvf nginx-1.13.7.tar.gz # 解压
```
## 3 安装nginx

``` bash
cd /usr/local/nginx # 进入nginx目录
cd nginx-1.13.7
./configure # 执行命令
make # 执行make命令
make install # 执行make install命令
```

## 4 配置nginx.conf

``` bash
vi /usr/local/nginx/conf/nginx.conf # 打开配置文件
```

// TODO

## 5 启动nginx

``` bash
/usr/local/nginx/sbin/nginx -s reload
```

查看nginx进程是否启动：

``` bash
ps -ef | grep nginx
```

## 6 访问服务器ip查看

## 7 一般常用命令

进入安装目录中，命令：
``` bash
cd /usr/local/nginx/sbin
```
启动，关闭，重启，命令：
``` bash
./nginx           # 启动
./nginx -s stop   # 关闭
./nginx -s reload # 重启
```
## 常见异常处理

### 1. nginx: [error] open() ＂/usr/local/nginx/logs/nginx.pid＂ failed

如果出现报错：`nginx: [error] open() ＂/usr/local/nginx/logs/nginx.pid＂ failed`

则运行： 

``` bash
/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
```
重新启动即可！

### 2. 外部主机访问虚拟机连接异常

若想使用外部主机连接上虚拟机访问端口192.168.131.2，需要关闭虚拟机的防火墙：

centOS6及以前版本使用命令： 
``` bash
systemctl stop iptables.service
```
centOS7关闭防火墙命令： 
``` bash
systemctl stop firewalld.service
```
随后访问该ip即可看到nginx界面。


## 参考

- [LINUX安装nginx详细步骤](https://blog.csdn.net/t8116189520/article/details/81909574)
