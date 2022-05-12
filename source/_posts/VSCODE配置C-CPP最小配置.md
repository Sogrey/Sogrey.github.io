---
title: VSCODE配置C/C++最小配置
author: Sogrey
date: 2022-5-13 00:59:34
tags: [VS code,c,c++]
categories: VS code
comments: true
toc: true
---

准备工具：

- [vscode](https://code.visualstudio.com/) (自行安装)
- [MinGW](https://nuwen.net/mingw.html) (C/C++环境)

## 安装C/C++环境--MinGW

进入网站[MinGW](https://nuwen.net/mingw.html)，点击如下图红框链接下载。

![下载MinGW](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/mingw-01.png)

解压出来MinGW放到你已知的目录下，我放在`D:\Programs\`下。

需将`MinGW\bin`目录添加到环境变量中，这样就能在vscode中访问到G++和GCC。

![配置MinGW环境变量](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/mingw-02.png)

![测试g++](https://cdn-1258560072.cos.ap-shanghai.myqcloud.com/picgo/mingw-03.png)

``` ps
PS G:\github\c\vscode-cpp> g++ --version
g++.exe (GCC) 11.2.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO      
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.     
```

## vscode安装c/c++插件

- [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
- [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)

## 测试

根据上面各项配置下来已经差不多了，写个简单c++程序测试一下。

test.cpp
``` c++
#include <iostream>

using namespace std;

int main(int argc, char const *argv[])
{
  cout << "Hello world";
  return 0;
}
```
vscode终端（PowerShell）中执行：`if ($?) { g++ test.cpp -o test } ; if ($?) { .\test }`
``` ps
PS G:\github\c\vscode-cpp> if ($?) { g++ test.cpp -o test } ; if ($?) { .\test}  
Hello world
```
成功生成`test.exe`并执行输出`Hello world`。

## 配置文件

为方便配置vscode中c/c++环境配置，在根目录下创建`.vscode`。添加如下几个配置文件：

[settings.json](https://github.com/Sogrey/vscode-cpp/blob/main/.vscode/settings.json) 主要为解决中文乱码问题
``` json
{
  "editor.tabSize": 2,
  "editor.detectIndentation": false,
  "[cpp]": {
    "editor.defaultFormatter": "ms-vscode.cpptools",
    "files.encoding": "gbk"
  },
  "[c]": {
    "editor.defaultFormatter": "ms-vscode.cpptools",
    "files.encoding": "gbk"
  }
}
```

[c_cpp_properties.json](https://github.com/Sogrey/vscode-cpp/blob/main/.vscode/c_cpp_properties.json)
``` json
{
    "configurations": [
        {
        "name": "GCC",
        "includePath": ["${workspaceFolder}/**"],
        "defines": ["_DEBUG", "UNICODE", "_UNICODE"],
        "windowsSdkVersion": "10.0.18362.0",
        "compilerPath": "D:\\Programs\\MinGW\\bin\\g++.exe",//改路径！！MinGW中g++.exe路径
        "cStandard": "c17",
        "cppStandard": "c++17",
        "intelliSenseMode": "windows-gcc-x64"
        }
    ],
    "version": 4
}
```

[launch.json](https://github.com/Sogrey/vscode-cpp/blob/main/.vscode/launch.json)
``` json
{
    "version": "0.2.0",
    "configurations": [
      {
        "name": "g++.exe - Build and debug active file",
        "type": "cppdbg",
        "request": "launch",
        "program": "${fileDirname}\\${fileBasenameNoExtension}.exe",
        "args": [],
        "stopAtEntry": false,
        "cwd": "${fileDirname}",
        "environment": [],
        "externalConsole": false,
        "MIMode": "gdb",
        "miDebuggerPath": "D:\\Programs\\MinGW\\bin\\gdb.exe",//改成你的mingw中gdb.exe的路径！！
        "setupCommands": [
          {
            "description": "Enable pretty-printing for gdb",
            "text": "-enable-pretty-printing",
            "ignoreFailures": true
          }
        ],
        "preLaunchTask": "C/C++: g++.exe build active file"
      }
    ]
  }
```

[tasks.json](https://github.com/Sogrey/vscode-cpp/blob/main/.vscode/tasks.json)
``` json
{
    "tasks": [
      {
        "type": "cppbuild",
        "label": "C/C++: g++.exe build active file",
        "command": "D:\\Programs\\MinGW\\bin\\g++.exe",//改为mingw中g++.exe路径
        "args": ["-g", "${file}", "-o", "${fileDirname}\\${fileBasenameNoExtension}.exe"],
        "options": {
          "cwd": "${fileDirname}"
        },
        "problemMatcher": ["$gcc"],
        "group": {
          "kind": "build",
          "isDefault": true
        },
        "detail": "compiler: D:\\Programs\\MinGW\\bin\\g++.exe"//改为mingw中g++.exe路径
      }
    ],
    "version": "2.0.0"
}
```

[github](https://github.com/Sogrey/vscode-cpp)