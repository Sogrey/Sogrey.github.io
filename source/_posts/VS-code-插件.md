---
title: VS code 插件
author: Sogrey
date: 2018-07-04 19:09:34
tags: [VS code]
categories: VS code
comments: true
toc: true
---

VS CODE 插件收集

> 已整理到：<https://sogrey.github.io/Plug-in/>  
>
> [征集插件，欢迎上报你觉得有用的插件](https://github.com/Sogrey/Plug-in/issues/1)

<!-- more -->

* 1. live-server 编辑浏览html网页

[github](https://github.com/tapio/live-server)

第一步： 安装Visual Studio Code + Node.JS

第二步：通过如下命令行安装live-server

在命令符中输入 `npm install -g live-server`进行安装

如果`npm install -g live-server`安装报错就用`npm install live-server -gf`安装

第三步：打开Visual Studio Code编写HTML代码，保存。

第四步：右击HTML文件所在的文件夹，选择“在命令提示符中打开”

第五步：输入`live-server`命令

第六步：选择HTML页面浏览即可

* 2. Markdown Preview Enhanced  作者：Yiyi Wang

[github](https://github.com/shd101wyy/vscode-markdown-preview-enhanced)

VS code 扩展直接搜索 `Markdown Preview Enhanced` 安装即可。

* 3. [Polacode](https://marketplace.visualstudio.com/items?itemName=pnp.polacode)  可以把代码生成图片（有些地方发代码结构会乱也没有代码高亮，这时候就可以生成图片再发）。

1. 快捷键 `Ctrl + Shift + P` 呼出命令窗 输入 `Polacode` 
2. 将要生成图片的代码复制到 Polacode 窗口
3. 点击最下面按钮保存图片

* 4. 另一个 [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer) ：可以一键在本地启动服务器。

* 5. [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) ：检查 js 语法规范，你可以使用不同的规范，如 airbnb 、standard 、google。
* 6. [TSLint](https://marketplace.visualstudio.com/items?itemName=eg2.tslint) ：检查 typescript 语法规范。
* 7. [Stylelint](https://marketplace.visualstudio.com/items?itemName=shinnn.stylelint) ：检查 CSS/SCSS/Less 语法规范。
* 8. [Markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) ：检查 markdown 语法规范。
* 9. [Emmet](https://emmet.io/) ：大家应该很熟悉这个插件了（很好用），VS Code 已经内置了，很到位。
* 10. [Auto Close Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-close-tag) ：自动闭合 html 等标签 （</...>）。
* 11. [Auto Rename Tag](https://marketplace.visualstudio.com/items?itemName=formulahendry.auto-rename-tag) ：修改 html 标签时，自动修改闭合标签。
* 12. [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense) ：自动提示补全路径。
* 13. [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) ：可以在编辑器里直接运行代码，查看结果。
* 14. [Color Picker](https://marketplace.visualstudio.com/items?itemName=anseki.vscode-color) ：可以直接在编辑器里打开色板，选择各种模式的颜色。
* 15. [Document This](https://marketplace.visualstudio.com/items?itemName=joelday.docthis) ：可以给函数、类等自动的加上详细的注释。
  快捷键 `Ctrl+Alt+D` and `again Ctrl+Alt+D`
* 16. [Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory) ：方便的查看git版本管理的详细信息。
* 17. [Settings Sync](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) ：重点介绍下这个插件，如果你有两台电脑（比如，家里和公司）都使用 VS Code ，可是在公司或家里对 VS Code 安装了插件或者修改了配置，回到家或公司又要重新弄一次，这个插件就能解决问题，同步多台电脑设置。只需要把配置上传到GitHub，在另一个地方下载配置即可





**1.Settings Sync**

最好用的插件，没有之一，一台电脑配置好之后，其它的几台电脑都不用配置。新机器登录一下就搞定了。再也不用折腾环境了，

使用GitHub Gist同步多台计算机上的设置，代码段，主题，文件图标，启动，键绑定，工作区和扩展。



![img](https:////upload-images.jianshu.io/upload_images/14464859-fb7068d23d498ddb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/657/format/webp)

**2.Debugger for Chrome**

从VS Code调试在Google Chrome中运行的JavaScript代码。

用于在Google Chrome浏览器或支持[Chrome DevTools协议的](https://chromedevtools.github.io/debugger-protocol-viewer/)其他目标中调试JavaScript代码的VS Code扩展。



![img](https:////upload-images.jianshu.io/upload_images/14464859-a0708139132b0af8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/690/format/webp)

**3.beautify**

格式化代码工具

美化`javascript`，`JSON`，`CSS`，`Sass`，和`HTML`在Visual Studio代码。



![img](https:////upload-images.jianshu.io/upload_images/14464859-4720f7961226fb6b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/639/format/webp)

**4.Atuo Rename Tag**

修改 html 标签，自动帮你完成头部和尾部闭合标签的同步修改



![img](https:////upload-images.jianshu.io/upload_images/14464859-cd4c695fa202b259.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/222/format/webp)

**5.中文（简体）语言包**

[Chinese (Simplified) Language Pack for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=MS-CEINTL.vscode-language-pack-zh-hans)

将界面转换为中文，对英语不好的人，非常友好。例如我。。。



![img](https:////upload-images.jianshu.io/upload_images/14464859-a5e8b1406a14df59.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/948/format/webp)

**6.Code Spell Checker**

代码拼写检查器

一个与camelCase代码配合良好的基本拼写检查程序。

此拼写检查程序的目标是帮助捕获常见的拼写错误，同时保持误报数量较低。



![img](https:////upload-images.jianshu.io/upload_images/14464859-45a28ae47762d653.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/689/format/webp)

**7.vscode-icons**

显示Visual Studio代码的图标，目前该插件已被vscode内部支持："文件" -> "首选项" -> "文件图标主题"



![img](https:////upload-images.jianshu.io/upload_images/14464859-203128b9031364a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/894/format/webp)

**8.guides**

显示代码对齐辅助线，很好用



![img](https:////upload-images.jianshu.io/upload_images/14464859-1618745c4fda4807.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/600/format/webp)

9.[Rainbow Brackets](https://marketplace.visualstudio.com/items?itemName=2gua.rainbow-brackets)

为圆括号，方括号和大括号提供彩虹色。这对于Lisp或Clojure程序员，当然还有JavaScript和其他程序员特别有用。

效果如下：



![img](https:////upload-images.jianshu.io/upload_images/14464859-2cdbe1b95b081ece.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/530/format/webp)

**10.Bracket Pair Colorizer**

用于着色匹配括号



![img](https:////upload-images.jianshu.io/upload_images/14464859-a977f0262f623d06.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/625/format/webp)

**11.Indent-Rainbow**

用四种不同颜色交替着色文本前面的缩进



![img](https:////upload-images.jianshu.io/upload_images/14464859-62d24545140dbe18.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/422/format/webp)

**12.filesize**

在状态栏中显示当前文件大小，点击后还可以看到详细创建、修改时间



![img](https:////upload-images.jianshu.io/upload_images/14464859-1357457acb1f876f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

**13.Import Cost**

对引入的计算大小



![img](https:////upload-images.jianshu.io/upload_images/14464859-3862c63254d26a9b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/784/format/webp)

**14.Path Intellisense**

可自动填充文件名。



![img](https:////upload-images.jianshu.io/upload_images/14464859-ba8192a422d38f39.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/480/format/webp)

**15.[WakaTime](https://marketplace.visualstudio.com/items?itemName=WakaTime.vscode-wakatime) **

从您的编程活动自动生成的度量标准，见解和时间跟踪。



![img](https:////upload-images.jianshu.io/upload_images/14464859-a82197ba581c44d1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

**16.GitLens**

git日志查看插件

GitLens 增强了 Visual Studio Code 中内置的 Git 功能。例如 commits 搜索，历史记录和和查看代码作者身份，还能通过强大的比较命令获得有价值的见解等等



![img](https:////upload-images.jianshu.io/upload_images/14464859-bf9b731fc13d26ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

**17..REST Client**

REST客户端允许您直接发送HTTP请求并在Visual Studio Code中查看响应。



![img](https:////upload-images.jianshu.io/upload_images/14464859-fdb6811c5c899e19.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/665/format/webp)

**18.[Npm Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.npm-intellisense) **

用于在 import 语句中自动填充 npm 模块

require 时的包提示（最新版的vscode已经集成此功能）



![img](https:////upload-images.jianshu.io/upload_images/14464859-b07c435a84dd3d97.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/921/format/webp)

**19.Azure Storage**

VS Code的Azure存储扩展允许您部署静态网站并浏览Azure Blob容器，文件共享，表和队列。按照[本教程](https://code.visualstudio.com/tutorials/static-website/getting-started)从VS Code部署Web应用程序到Azure存储。



![img](https:////upload-images.jianshu.io/upload_images/14464859-1f1b4ac882f302aa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/683/format/webp)

**20.Project Manager**

它可以帮助您轻松访问项目，无论它们位于何处。*不要再错过那些重要的项目了*。您可以定义自己的**收藏**项目，或选择自动检测**VSCode**项目，**Git**，**Mercurial**和**SVN**存储库或**任何**文件夹。

从版本8开始，您就有了专门的项目**活动栏**！

以下是**Project Manager**提供的一些功能：

- 将任何项目保存为**收藏夹** 
- 自动检测**VSCode**，**GIT中**，**水银**或**SVN**存放区
- 在相同或新窗口中打开项目
- 识别*已删除/重命名的*项目
- 一个**状态栏**标识当前项目
- 专门的**活动栏** 



![img](https:////upload-images.jianshu.io/upload_images/14464859-7d3c5f109f1ccf5a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700/format/webp)

**21.Language Support for Java(TM) by Red Hatredhat.java**

这个插件，这个下载次数，安装就对了。



![img](https:////upload-images.jianshu.io/upload_images/14464859-b6341da4f97e7344.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/859/format/webp)

**22.[Todo Tree](https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree) **

此扩展可以快速搜索（使用[ripgrep](https://github.com/BurntSushi/ripgrep)）您的工作区以获取TODO和FIXME等注释标记，并在资源管理器窗格的树视图中显示它们。单击树中的TODO将打开文件并将光标放在包含TODO的行上。

找到的TODO也可以在打开的文件中突出显示。



![img](https:////upload-images.jianshu.io/upload_images/14464859-60725a36424f0e85.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

### b.VS code 主题集合

#### 1.[Night Owl](https://marketplace.visualstudio.com/items?itemName=sdras.night-owl) 

一个非常适合夜猫子的 VS Code 主题。像是为喜欢深夜编码的人精心设计的。



![img](https:////upload-images.jianshu.io/upload_images/14464859-19c33539e14f5928.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/901/format/webp)

#### 2.[Atom One Dark Theme](https://marketplace.visualstudio.com/items?itemName=akamud.vscode-theme-onedark) 

一个基于Atom的黑暗主题



![img](https:////upload-images.jianshu.io/upload_images/14464859-3e38dbdf95fbb2ff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)

#### 3.[Dracula Official](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula) 

官方吸血鬼主题，博主用的就是这款，很漂亮



![img](https:////upload-images.jianshu.io/upload_images/14464859-2beb37cb8fb13d11.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/740/format/webp)

image

#### 4.[One Dark Pro](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme) 

Atom标志性的One Dark主题，也是VS Code下载次数最多的主题之一！



![img](https:////upload-images.jianshu.io/upload_images/14464859-f5144ce214a675b8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/804/format/webp)

#### 5.[Bimbo](https://marketplace.visualstudio.com/items?itemName=pawelgrzybek.bimbo-theme) 

简约而现代的神奇海洋主题



![img](https:////upload-images.jianshu.io/upload_images/14464859-1467662db4e0a1af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/863/format/webp)

### c.代码提示提示类

#### 1.[HTML Snippets](https://marketplace.visualstudio.com/items?itemName=abusaidm.html-snippets) 

完整的HTML代码提示，包括HTML5



![img](https:////upload-images.jianshu.io/upload_images/14464859-5f3d80192ea28514.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/640/format/webp)

#### 2.[HTML CSS Support](https://marketplace.visualstudio.com/items?itemName=ecmel.vscode-html-css) 

在 html 标签上写class 智能提示css样式



![img](https:////upload-images.jianshu.io/upload_images/14464859-c88c506ed0224f8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/522/format/webp)

#### 3.[jQuery Code Snippets](https://marketplace.visualstudio.com/items?itemName=donjayamanne.jquerysnippets) 

jQuery代码提示

超过130个用于JavaScript代码的jQuery代码片段。

只需键入字母'jq'即可获得所有可用jQuery代码片段的列表。



![img](https:////upload-images.jianshu.io/upload_images/14464859-cbb4ea684fbc0066.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/561/format/webp)

#### 4.[HTMLHint](https://marketplace.visualstudio.com/items?itemName=mkaufman.HTMLHint) 

html代码检测，支持html5



![img](https:////upload-images.jianshu.io/upload_images/14464859-9cb58f52216b348e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/445/format/webp)

