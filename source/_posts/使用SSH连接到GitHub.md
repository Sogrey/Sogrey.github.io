---
title: 使用SSH连接到GitHub
date: 2021-08-21 20:50:49
tags: [Github,SSH]
categories: SSH
comments: true
toc: true
---

据悉，GitHub防黑客新措施：弃用账密验证Git操作，改用token或SSH密钥，8月14号0点（8月13日9:00 PST）开始，在GitHub上执行Git操作就会导致失败。

GitHub官方表示，这一举措是为了提高Git操作的安全性，防止密码撞库等事情发生。

现在，GitHub开始强制用户采用token或SSH密钥进行身份验证。相比于账密，这两者的安全性显然更高：
- 唯一性：仅限GitHub使用，根据设备/使用次数生成
- 可撤销性：可随时被单独撤销，其他凭证不受影响
- 区域性：使用范围可控，只允许在部分访问活动中执行
- 随机性：不受撞库影响，比账密复杂度更高

虽然目前GitHub官方推荐的是token，因为它设置更为简单，不过相比之下，SSH密钥的安全性要更高一些。

<!--more-->

## 本地生成新的 SSH 密钥

### 设置git的user name和email

如果你是第一次使用，或者还没有配置过的话需要操作一下命令，自行替换相应字段:

``` bash
git config --global user.name "<Your Name>"
git config --global user.email "<Your Email>"
```

> Tips:
>
> `git config --list` 查看当前Git环境所有配置，还可以配置一些命令别名之类的。

### 检查是否存在SSH Key

打开Git Bash,输入：

``` bash
ls -al ~/.ssh
```

来查看是否有ssh key存在。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Checking%20for%20existing%20SSH%20keys.png)

如图，提示不存在，下面准备生成新的SSH。

### 生成一个新的SSH key并添加到ssh-agent

打开Git Bash,输入：

``` bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

> **注意：**如果您使用的是不支持 Ed25519 算法的旧系统，请使用：
>
> ```shell
> ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
> ```

生成一个新的ssh key，使用填入的邮箱地址作为ssh key的标签，并生成RSA密钥对。

看到如下提示时按下回车，表示把ssh key放在默认地址：

``` bash
Enter file in which to save the key (/c/Users/Administrator/.ssh/id_rsa):
```

然后为ssh key设置密码

``` bash
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Generating%20a%20new%20SSH%20key%20and%20adding%20it%20to%20the%20ssh-agent.png)

创建完ssh key后，你需要把它添加到ssh-agent中去。

首先保证ssh-agent启用了：

``` bash
eval "$(ssh-agent -s)"
```

该指令返回进程id则表示已经启用ssh-agent

使用如下指令把ssh key添加到ssh-agent中:

``` bash
ssh-add ~/.ssh/id_rsa
```

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/adding%20ssh%20to%20the%20ssh-agent.png)

### 为你的github账号添加SSH key

在把ssh key添加到ssh-agent后，你需要把ssh key添加到你的github账号中。

打开Git Bash，使用指令把ssh key复制到剪贴板：

``` bash
clip < ~/.ssh/id_rsa.pub
```

登录Github,依次点击`Settings` > `SSH and GPG keys` > `New SSH key`,在`Key`一栏输入刚刚复制的ssh key, Title一栏随便填写：

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Adding%20a%20new%20SSH%20key%20to%20your%20GitHub%20account.png)

填写完成点击`Add SSH key`后需要输入github密码验证即可。

### 测试你的SSH连接

操作完以上一系列操作，是时候测试下刚配置的SSH是否成功。

打开Git Bash，输入以下指令：

``` bash
ssh -T git@github.com
```

尝试去用ssh连接github，看到一些警告信息

```
The authenticity of host 'github.com (140.82.113.3)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

只管输入`yes`就好。你将会看到如下信息：

``` 
Hi Sogrey! You've successfully authenticated, but GitHub does not provide shell access.
```

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Testing%20your%20SSH%20connection.png)

则表示ssh连接成功了。如果收到`access denied`,可参考[这里](https://help.github.com/articles/error-permission-denied-publickey/)。

### 改变远程仓库的URL

SSH配置完成后，需要把远程仓库URL由HTTPS改为SSH。

打开Git Bash，转到工作目录下，先查看远程仓库地址：

``` bash
git remote -v
```

更改远程仓库的url:

``` bash
 git remote set-url origin git@github.com:USERNAME/OTHERREPOSITORY.git
```

origin为仓库名，后面接的是ssh仓库地址。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Changing%20a%20remote's%20URL.png)

到此Github的SSH key配置大功告成。

## 为TortoiseGit添加SSH

我比较喜欢使用可视化工具，TortoiseGit就是其中之一，Github这次强制用户采用token或SSH密钥进行身份验证也影响到了TortoiseGit的使用，下面进行TortoiseGit的SSH配置。

找到TortoiseGit自带的PuTTYgen工具，打开后点击Generate(**生成的过程中记得移动鼠标**)

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Create%20SSH%20key%20by%20PuTTY%20Key%20Generator.png)

PuTTYgen工具窗口先不要关闭，将框中显示的公钥复制下来依照[之前提到的](#为你的github账号添加SSH-key)添加到github的ssh。

点击PuTTYgen工具窗口`Save private key`保存一个`.ppk`文件，适当命名找个目录存档。

找到TortoiseGit自带的`Pageant Key List`工具,点击`Add Key`添加刚刚保存的`.ppk`文件即可。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Add%20ppk%20file%20into%20Pageant%20Key%20List.png)

## 参考

- [使用SSH 连接到 GitHub - GitHub Docs](https://docs.github.com/cn/github/authenticating-to-github/connecting-to-github-with-ssh)
- [Creating a personal access token - GitHub Docs](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [Generating a new SSH key and adding it to the ssh-agent - GitHub Docs](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

