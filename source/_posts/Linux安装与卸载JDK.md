---
title: Linux安装与卸载JDK
date: 2021-08-19 21:14:03
tags: [Linux,JDK]
categories: Linux
comments: true
toc: true
---



## 安装JDK

### Ubuntu

网络畅通时可选择在线安装，简单方便。

``` bash
sudo apt-get update
sudo apt-get install default-jre
sudo apt-get install default-jdk
```
以上是默认的安装版本。如果想安装特定的版本：
``` bash
sudo apt-get install openjdk-7-jre
sudo apt-get install openjdk-7-jdk
```

离线安装。

下载jdk压缩包， 创建一个目录来存放jdk,并解压tar ：

``` bash
sudo mkdir /usr/lib/jvm
sudo tar -zxvf jdk-8u181-linux-x64.tar.gz -C /usr/lib/jvm
```
解压后可删除压缩包：
``` bash
rm -rf jdk-7u79-linux-x64.tar.gz
```
修改环境变量
``` bash
sudo vim ~/.bashrc
```
文件末尾追加如下内容
``` bash
#set oracle jdk environment
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_181  ## 这里要注意目录要换成自己解压的jdk 目录
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH  
```
使环境变量生效
``` bash
source ~/.bashrc
```
设置默认jdk
``` bash
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_181/bin/java 300  
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_181/bin/javac 300  
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk1.8.0_181/bin/jar 300   
sudo update-alternatives --install /usr/bin/javah javah /usr/lib/jvm/jdk1.8.0_181/bin/javah 300   
sudo update-alternatives --install /usr/bin/javap javap /usr/lib/jvm/jdk1.8.0_181/bin/javap 300 
```
执行
``` bash
sudo update-alternatives --config java
```
测试是否安装成功
``` bash
java -version
javac -version
```
## 卸载JDK

### Ubuntu

要删除 OpenJDK (如果已安装的话)。首先，检查是安装的哪个 OpenJDK包。

``` bash
# dpkg --list | grep -i jdk
```

移除 openjdk包:

```  bash
# apt-get purge openjdk*
```

卸载 OpenJDK 相关包：

```  bash
# apt-get purge icedtea-* openjdk-*
```

检查所有 OpenJDK包是否都已卸载完毕：

```  bash
# dpkg --list | grep -i jdk
```

完毕。

