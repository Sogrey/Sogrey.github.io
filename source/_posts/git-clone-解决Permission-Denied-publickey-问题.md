---
title: git clone 解决Permission Denied (publickey)问题
date: 2019-04-22 17:35:45
author: Sogrey
tags: [git]
categories: Git
comments: true
toc: true
---

本地git bash 使用`git clone git@github.com:***.git`方式下载github代码至本地时需要依赖ssh key，遇到权限不足问题时一般都是SSH key失效或者SSH key不存在，重新创建SSH key一般就可以解决问题；

<!--more-->

## 步骤一、检查本地ssh key是否存在

1、windows下 开始 -- 搜索框输入 git bash，打开git bash窗口；
    
2、git base窗口中输入指令 ls ~/.ssh/ 来检查ssh key是否存在；
    
3、如果key不存在则按照步骤二重新生成，ssh key已存在则跳过步骤二，执行步骤三；

## 步骤二、生成ssh key

1、继续步骤一的git bash窗口执行指令：

``` bash
ssh-keygen -t rsa -b 2048 -C "你自己的邮箱地址"
```

> 修改邮箱地址为你自己的邮箱地址，注意此处邮箱地址前后的双引号为英文格式双引号；

2、指令执行后页面提示：

```
Generating public/private rsa key pair.
Enter file in which to save the key (/c/Users/{你当前登录名}/.ssh/id_rsa):
```

不做修改直接回车，会将生成的rsa文件保存为默认名称`id_rsa`,在`c/Users/{你当前登录名}/.ssh/`目录下可以找到。

再次回车提示：

```
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
```
提示设置提交/l拉取代码到Github时需要的密码及确认密码；

> 注意：输入密码时不会显示密码，所以输入时没有任何显示不要惊讶。输完直接回车就行。

设置密码后再次回车提示Your identification has been saved in.... 即表示ssh key生成成功；

## 步骤三、添加sshkey至ssh-agent

1、执行 `eval $(ssh-agent -s)` 确认ssh-agent处于开启状态，打印pid... 表示启用中；[出处](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)

2、执行指令  `ssh-add ~/.ssh/id_rsa`   添加ssh key至ssh agent，此步会要求输入步骤二设置的密码；

需要注意的是此处可能报错：`Could not open a connection to your authentication agent`，我的解决办法是关掉当前git bash窗口，重新以管理员身份运行git bash 即解决问题；

## **步骤四、添加ssh key至guthub**

 1、登录<https://github.com/>，在页面右上角自己头像右边箭头处右击，弹框中进入setting功能；

 2、setting界面右边菜单选择SSH and GPG keys，选择新建SSH keys，

> 其中：
>
> title：{随便填}
>
> Key: 打开第二步生成的`id_rsa.pub`,将文件内容填入。也可以执行`cat ~/.ssh/id_rsa.pub`来查看内容。

保存即可。

## **步骤五：git clone下载代码**

此时再尝试本地使用git clone方式下载代码即可；

## 参考：

- <https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys>

- <https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key>

- [github结合TortoiseGit使用sshkey，无需输入账号和密码](https://www.cnblogs.com/chucklu/p/4056499.html)

