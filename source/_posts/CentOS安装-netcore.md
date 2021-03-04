---
title: CentOS安装.netcore
date: 2021-03-04 20:49:28
tags: [Linux,CentOS,.netcore]
categories: Linux
comments: true
toc: true
---



## 安装.Net Core

``` bash
sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
sudo yum update -y
sudo yum install -y dotnet-runtime-2.1
dotnet --info

```


## 安装.Net Core SDK
``` bash
sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
sudo yum update -y
sudo yum install -y dotnet-sdk-2.1
dotnet --version

```
 

## 安装Asp.Net Core
``` bash
sudo rpm -Uvh https://packages.microsoft.com/config/rhel/7/packages-microsoft-prod.rpm
sudo yum update -y
sudo yum install -y aspnetcore-runtime-2.1
dotnet --info

```
 

## 卸载.Net Core
``` bash
sudo yum remove -y aspnetcore-*
sudo yum remove -y dotnet-*

```

 

## 参考

- [https://www.microsoft.com/net/download/linux-package-manager/centos/sdk-current](https://www.microsoft.com/net/download/linux-package-manager/centos/sdk-current)