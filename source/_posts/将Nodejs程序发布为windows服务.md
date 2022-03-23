---
title: 将Nodejs程序发布为windows服务
date: 2022-03-23 23:41:30
author: Sogrey
tags: [node.js,Windows]
categories: node.js
comments: true
toc: true
---


利用[node-windows](https://www.npmjs.com/package/node-windows)，将nodejs程序发布为windows服务。

## 安装

安装 node-windows 的推荐方法是使用 npm，使用全局标志：
``` bash
npm install -g node-windows
```
然后，在您的项目根目录中，运行：
``` bash
npm link node-windows
```

## 生成文件

npm库介绍上有段说明。

node-windows 有一个实用程序可以将 Node.js 脚本作为 Windows 服务运行。请注意，像所有 Windows 服务一样，创建一个需要管理权限。要使用节点窗口创建服务，请准备如下类似脚本：

``` js
var Service = require('node-windows').Service;

var svc = new Service({
  name: 'myservice',
  description: 'this is my windows service',
  script: require('path').join(__dirname, 'client.js'),
  nodeOptions: [
    '--harmony',
    '--max_old_space_size=4096'
  ]
});

svc.on('install', function () {
  svc.start();
});

svc.on('uninstall', function () {
  console.log('Uninstall complete.');
  console.log('The service exists: ', svc.exists);
});

svc.on('error ', function () {

})

svc.install();
```
该Service对象发出以下事件：

- `install` - 当脚本作为服务安装时触发。
- `alreadyinstalled` - 如果脚本已知是服务则触发。
- `invalidinstallation` - 如果检测到安装但缺少所需文件则触发。
- `uninstall` - 卸载完成时触发。
- `alreadyuninstalled` - 请求卸载但不存在安装时触发。
- `start` - 新服务启动时触发。
- `stop` - 服务停止时触发。
- `error` - 在某些情况下发生错误时触发。

## 管理服务

安装
``` cmd
sc.exe create qqian binpath='./deamon/myservice.exe'  start=auto
[SC] CreateService 成功
```
删除
``` cmd
sc.exe delete "myservice.exe"
```
启动
``` cmd
net start myservice
```
停止
``` cmd
net stop myservice
```