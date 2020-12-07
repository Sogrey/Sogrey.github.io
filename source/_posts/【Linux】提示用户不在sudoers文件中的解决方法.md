---
title: 【Linux】提示用户不在sudoers文件中的解决方法
date: 2020-12-07 10:20:58
tags: [Linux,sudo,sudoers]
categories: Linux
comments: true
toc: true
---

 在使用Linux系统过程中，通常情况下，我们都会使用普通用户进行日常操作，而root用户只有在权限分配及系统设置时才会使用，而root用户的密码也不可能公开。普通用户执行到系统程序时，需要临时提升权限，sudo就是我们常用的命令，仅需要输入当前用户密码，便可以完成权限的临时提升。在使用sudo命令的过程中，我们经常会遇到当前用户不在sudoers文件中的提示信息，如果解决该问题呢？通过下面几个步骤，可以很简单的解决此问题。

<!--more-->

1. 切换到root用户权限

``` bash
su root
密码 #输入密码，密码不可见
```

2. 查看`/etc/sudoers`文件权限，通常是只读权限，修改为可写权限

``` bash
ls -l /etc/sudoers # 查看文件权限
-r--r-----. 1 root root 4030 9月  25 00:57 /etc/sudoers #r读 w写 目前是只读状态
chmod 777 /etc/sudoers # 修改为可写权限
ls -l /etc/sudoers # 再次查看文件权限
-rwxrwxrwx. 1 root root 4030 9月  25 00:57 /etc/sudoers #r读 w写 现在是可写状态
```

3. 执行`vi`命令，编辑`/etc/sudoers`文件，添加要提升权限的用户；

``` bash 
vi ./etc/sudoers
```
在文件中找到`root  ALL=(ALL) ALL`，在该行下添加提升权限的用户信息，如：
``` 
root    ALL=(ALL)       ALL
user    ALL=(ALL)       ALL
```
说明：格式为（`用户名    网络中的主机=（执行命令的目标用户）    执行的命令范围`）

保存退出`vi`,按`Esc`键输出`:wq`。

    编辑模式
    　　使用vi进入文本后，按i开始编辑文本

    退出编辑模式 
    　　按ESC键，然后：
    　　　　退出vi
    　　　 :q!  不保存文件，强制退出vi命令
    　　　 :w   保存文件，不退出vi命令
    　　　 :wq  保存文件，退出vi命令


4. 保存退出后恢复`/etc/sudoers`的访问权限为`440`

``` bash
chmod 440 /etc/sudoers # 恢复只读
ls -l /etc/sudoers # 查看文件读写状态
-r--r-----. 1 root root 4030 9月  25 00:57 /etc/sudoers # r读 w写 目前只读
```

进行完以上步骤，切换回普通用户，该用户权限提升功能完成。

![linux提升用户权限sudoers](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/linux提升用户权限sudoers.png)