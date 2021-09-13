---
title: windows下修改vscode默认终端为git bash
date: 2021-09-13 23:31:20
tags: [VSCode,Git,Bash]
categories: VSCode
comments: true
toc: true
---


最近我的Windows 10系统提示需要更新，而且是到了最后时间，将来将不会再为我推送更新提醒，我一般不愿意更新系统，浪费时间还老是出问题，这次看来非更新不可了，这或许又是微软的套路吧。

果然更新后，微软无耻的把自己的`Powershell`推上了舞台，这个工具好不好用不知道，我一般就用`CMD`和`Git Bash`,使用`Git Bash`会更多一些。

目前我做前端多一些，VSCode则是必不可少的编辑器了。自从系统更新后，VSCode终端就默认使用`Powershell`（如下图）,这让我一些`Bash`脚本无法执行，今天就来修改VSCode默认终端为`Git Bash`。

<!--more-->

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/vscode-git-bash-01.png)

点击VSCode左下角的齿轮，展开点击[设置]

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/vscode-git-bash-02.png)

搜索关键词`shell`,选择`终端` > `Terminal › Integrated › Automation Shell: Windows` > `在 settings.json 中编辑`

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/vscode-git-bash-03.png)

我之前配置的是下面这个，已经不能用了（具体可参考 [Integrated Terminal](https://code.visualstudio.com/docs/editor/integrated-terminal#_configuration)）：

``` json
"terminal.integrated.profiles.windows": "C:\\Program Files\\Git\\bin\\bash.exe",
```

将以下内容加到配置文件大括弧内：
``` json
"terminal.integrated.profiles.windows": {
    "PowerShell -NoProfile": {
      "source": "PowerShell",
      "args": [
        "-NoProfile"
      ]
    },
    "Git-Bash": {
      "path": "C:\\Program Files\\Git\\bin\\bash.exe",
      "args": []
    }
  },
"terminal.integrated.defaultProfile.windows": "Git-Bash",
```

我的 `Git bash` 安装在C盘就写C盘路径。

关闭配置，回到终端，点击下拉箭头，可以看到很多可选终端，并且`Git bash`设为默认，新建一个终端默认使用`Git Bash`。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/vscode-git-bash-04.png)

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/vscode-git-bash-05.png)

终于我的`Bash`脚本又飞起来了。

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/vscode-git-bash-06.png)