---
title: Linux中让shell脚本变成可执行文件
date: 2021-03-07 00:36:36
tags: [Linux,shell]
categories: Linux
comments: true
toc: true
---

如何创建Linux脚本，在Linux中创建脚本如何运行？

<!--more-->

先创建一个脚本文件`run.sh`：
``` bash
touch run.sh
```
输入内容：
``` bash
#!/bin/bash
# Author : Sogrey

echo "What's your name?"
read PERSON
echo "Hello, $PERSON"
```

## sh/bash执行Bash脚本

``` bash
[sogrey@bogon 文档]$ sh run.sh
What's your name?
Sogrey
Hello, Sogrey
[sogrey@bogon 文档]$ bash run.sh
What's your name?
Sogrey
Hello, Sogrey
```

## chmod命令设置可执行权限
``` bash
[sogrey@bogon 文档]$ chmod +x ./run.sh
[sogrey@bogon 文档]$ ll
总用量 28
-rwx------. 1 sogrey sogrey   90 3月   7 12:02 run.sh
[sogrey@bogon 文档]$ ./run.sh
What's your name?
Sogrey
Hello, Sogrey
[sogrey@bogon 文档]$ 
```
## shc打包二进制文件

### gzexe加密

gzexe命令即可隐藏shell源码，这个命令是系统自带的gzexe程序。在运用中， gzexe  script.sh会把原来没有加密的文件备份为 script.sh~ ,同时 script.sh 即被变成加密文件。 gzexe  -d script.sh会解密还原脚本，所以只能够满足一般的加密用途。

``` bash
[sogrey@bogon 文档]$ gzexe run.sh # 加密
run.sh:	  7.8%
[sogrey@bogon 文档]$ gzexe -d run.sh # 解密
[sogrey@bogon 文档]$ 
```

### shc打包二进制文件

在源中搜索软件：`apt-cache search shc`，显示shc为Shell script compiler，然后安装 `apt-get install shc` ，安装后程序放置于/usr/bin/shc。

shc把shell脚本封装为一个可执行的二进制文件，`shc -h`查看使用方法。

`shc -v -r -f run.sh` 打包成`run.sh.x`二进制文件，同时生成`run.sh.x.c`文件，这个为C语言文件。猜想这个工具是将shell脚本转为C语言，然后在打包成二进制文件。

如果打包不成功的话，`shc -h`最下面有environment环境要求，要在保证满足。

### shc的反编译UnSHc

github上克隆：`git clone https://github.com/yanncam/UnSHc.git`，文件夹lastest中有个脚本`unshc.sh`可以完成反编译功能。

`./unshc.sh -h`查看使用方法，笔者使用sample里面的例程测试可以。但是笔者觉得这个工具意义不大，除非知道二级制文件是使用shc来编译的，不然反编译出来也不成功。反编译UnSHc对于开发人员来说作用不大。


## 参考

- [如何让shell脚本变成可执行文件](https://www.jianshu.com/p/69ce43a5c355)
- [Linux中将shell脚本打包为可执行文件](https://www.jianshu.com/p/fae2e9b1d1f6)