---
layout: oracle
title: Oracle VM VirtualBox 中为 CentOS 安装增强工具
date: 2021-05-23 00:26:09
tags: [VirtualBox,CentOS]
categories: 虚拟机
comments: true
toc: true
---

最近需要在linux上测试程序，Oracle VM VirtualBox上安装了CentOS，但是增强工具安装不成功，导致共享文件夹不能使用，主机与虚拟机之间不能文件交换，特此记录解决方案，以备后用。
<!--more-->
![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Oracle%20VM%20VirtualBox%20%E4%B8%AD%E4%B8%BA%20CentOS%20%E5%AE%89%E8%A3%85%E5%A2%9E%E5%BC%BA%E5%B7%A5%E5%85%B7.png)

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Oracle%20VM%20VirtualBox%20%E4%B8%AD%E4%B8%BA%20CentOS%20%E5%AE%89%E8%A3%85%E5%A2%9E%E5%BC%BA%E5%B7%A5%E5%85%B7%E5%87%BA%E9%94%99.png)

``` bash
Verifying archive integrity... All good.
Uncompressing VirtualBox 6.1.20 Guest Additions for Linux........
VirtualBox Guest Additions installer
Removing installed version 6.1.16 of VirtualBox Guest Additions...
Copying additional installer modules ...
Installing additional modules ...
VirtualBox Guest Additions: Starting.
VirtualBox Guest Additions: Building the VirtualBox Guest Additions kernel 
modules.  This may take a while.
VirtualBox Guest Additions: To build modules for other installed kernels, run
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup <version>
VirtualBox Guest Additions: or
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup all
VirtualBox Guest Additions: Building the modules for kernel 
4.18.0-240.1.1.el8_3.x86_64.

VirtualBox Guest Additions: Look at /var/log/vboxadd-setup.log to find out what 
went wrong
modprobe vboxguest failed
The log file /var/log/vboxadd-setup.log may contain further information.
Press Return to close this window...
```

查看错误日志`/var/log/vboxadd-setup.log`:

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Oracle%20VM%20VirtualBox%20%E4%B8%AD%E4%B8%BA%20CentOS%20%E5%AE%89%E8%A3%85%E5%A2%9E%E5%BC%BA%E5%B7%A5%E5%85%B7-%E6%9F%A5%E7%9C%8B%E9%94%99%E8%AF%AF%E6%97%A5%E5%BF%97.png)

``` bash
[sogrey@localhost ~]$ sudo cat /var/log/vboxadd-setup.log
[sudo] sogrey 的密码：
Building the main Guest Additions 6.1.20 module for kernel 4.18.0-240.1.1.el8_3.x86_64.
Error building the module.  Build output follows.
make V=1 CONFIG_MODULE_SIG= CONFIG_MODULE_SIG_ALL= -C /lib/modules/4.18.0-240.1.1.el8_3.x86_64/build M=/tmp/vbox.0 SRCROOT=/tmp/vbox.0 -j2 modules
make[1]: warning: -jN forced in submake: disabling jobserver mode.
Makefile:978: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.
make: *** [/tmp/vbox.0/Makefile-footer.gmk:117: vboxguest] Error 2
modprobe vboxguest failed
[sogrey@localhost ~]$
```

提示我们`Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel`.

我们逐一尝试安装，貌似只有最后一个有效：

``` bash
[sogrey@localhost ~]$ sudo yum install elfutils-libelf-devel
[sudo] sogrey 的密码：
CentOS Linux 8 - BaseOS                                143  B/s | 3.9 kB     00:27    
CentOS Linux 8 - Extras                                2.7 kB/s | 1.5 kB     00:00    
CentOS Linux 8 - PowerTools                            6.9 kB/s | 4.3 kB     00:00    
Docker CE Stable - x86_64                              6.1 kB/s | 3.5 kB     00:00    
Extra Packages for Enterprise Linux Modular 8 - x86_64  32 kB/s | 9.9 kB     00:00    
Extra Packages for Enterprise Linux Modular 8 - x86_64 482 kB/s | 612 kB     00:01    
Extra Packages for Enterprise Linux 8 - x86_64          30 kB/s |  11 kB     00:00    
Extra Packages for Enterprise Linux 8 - x86_64         1.3 MB/s | 9.4 MB     00:07    
packages-microsoft-com-prod                             10 kB/s | 3.0 kB     00:00    
packages-microsoft-com-prod                             80 kB/s | 2.9 MB     00:37    
依赖关系解决。
=======================================================================================
 软件包                        架构           版本                仓库            大小
=======================================================================================
安装:
 elfutils-libelf-devel         x86_64         0.180-1.el8         baseos          58 k

事务概要
=======================================================================================
安装  1 软件包

总下载：58 k
安装大小：34 k
确定吗？[y/N]： y
下载软件包：
[MIRROR] elfutils-libelf-devel-0.180-1.el8.x86_64.rpm: Curl error (28): Timeout was reached for http://mirrors.cqu.edu.cn/CentOS/8.3.2011/BaseOS/x86_64/os/Packages/elfutils-libelf-devel-0.180-1.el8.x86_64.rpm [Connection timed out after 30000 milliseconds]
elfutils-libelf-devel-0.180-1.el8.x86_64.rpm           1.9 kB/s |  58 kB     00:30    
---------------------------------------------------------------------------------------
总计                                                   1.9 kB/s |  58 kB     00:30     
运行事务检查
事务检查成功。
运行事务测试
事务测试成功。
运行事务
  准备中  :                                                                        1/1 
  安装    : elfutils-libelf-devel-0.180-1.el8.x86_64                               1/1 
  运行脚本: elfutils-libelf-devel-0.180-1.el8.x86_64                               1/1 
  验证    : elfutils-libelf-devel-0.180-1.el8.x86_64                               1/1 
Installed products updated.

已安装:
  elfutils-libelf-devel-0.180-1.el8.x86_64                                             

完毕！
[sogrey@localhost ~]$ 
```

安装完成后移出增强工具虚拟盘，重新挂载安装增强工具，遗憾，仍然失败：

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Oracle%20VM%20VirtualBox%20%E4%B8%AD%E4%B8%BA%20CentOS%20%E5%AE%89%E8%A3%85%E5%A2%9E%E5%BC%BA%E5%B7%A5%E5%85%B7-%E7%A7%BB%E9%99%A4%E8%99%9A%E6%8B%9F%E7%9B%98.png)

``` bash
Verifying archive integrity... All good.
Uncompressing VirtualBox 6.1.20 Guest Additions for Linux........
VirtualBox Guest Additions installer
Removing installed version 6.1.20 of VirtualBox Guest Additions...
Copying additional installer modules ...
Installing additional modules ...
VirtualBox Guest Additions: Starting.
VirtualBox Guest Additions: Building the VirtualBox Guest Additions kernel 
modules.  This may take a while.
VirtualBox Guest Additions: To build modules for other installed kernels, run
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup <version>
VirtualBox Guest Additions: or
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup all
VirtualBox Guest Additions: Building the modules for kernel 
4.18.0-240.1.1.el8_3.x86_64.
ValueError: File context for /opt/VBoxGuestAdditions-6.1.20/other/mount.vboxsf already defined
Press Return to close this window...
```

注意提示`ValueError: File context for /opt/VBoxGuestAdditions-6.1.20/other/mount.vboxsf already defined`,说这个文件已经存在，网上找到这个帖子[ValueError: mount.vboxsf already defined](https://www.virtualbox.org/ticket/19756) ,帖子末尾给出两句命令：

``` bash
# semanage fcontext -d /opt/VBoxGuestAdditions-<VERSION>/other/mount.vboxsf
# restorecon /opt/VBoxGuestAdditions-<VERSION>/other/mount.vboxsf
```

在终端依次执行，注意需要root权限执行，替换`<VERSION>` 为你当前安装的增强工具版本号，前面截图中有标识`6.1.20`。

完成后，再一次移除虚拟盘，重新挂载安装：

``` bash
Verifying archive integrity... All good.
Uncompressing VirtualBox 6.1.20 Guest Additions for Linux........
VirtualBox Guest Additions installer
Removing installed version 6.1.20 of VirtualBox Guest Additions...
Copying additional installer modules ...
Installing additional modules ...
VirtualBox Guest Additions: Starting.
VirtualBox Guest Additions: Building the VirtualBox Guest Additions kernel 
modules.  This may take a while.
VirtualBox Guest Additions: To build modules for other installed kernels, run
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup <version>
VirtualBox Guest Additions: or
VirtualBox Guest Additions:   /sbin/rcvboxadd quicksetup all
VirtualBox Guest Additions: Building the modules for kernel 
4.18.0-240.1.1.el8_3.x86_64.
VirtualBox Guest Additions: Running kernel modules will not be replaced until 
the system is restarted
Press Return to close this window...
```

ok，成功了（可能需要重启），可以尽情使用共享文件夹功能了。
