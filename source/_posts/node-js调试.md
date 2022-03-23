---
title: node.js调试
author: Sogrey
date: 2019-03-22 10:23:20
tags: [node.js]
categories: node.js
comments: true
toc: true
---

一般我们在调试javascript代码时常用的调试方法有：console日志和借助浏览器断点调试。

今遇到要调试node.js。Nodejs提供了一个内建调试器来帮助开发者调试应用程序。想要开启调试器我们需要在代码中加入debugger标签，当Nodejs执行到debugger标签时会自动暂停（debugger标签相当于在代码中开启一个断点）。

先看下几个命令的 说明：

**Stepping**

- `cont`, `c` - Continue execution 继续执行,直到遇到下一个断点
- `next`, `n` - Step next 单步执行
- `step`, `s` - Step in 单步执行并进入函数
- `out`, `o` - Step out 从函数中步出
- `pause` - Pause running code (like pause button in Developer Tools)

**Breakpoints**

- `setBreakpoint()`, `sb()` - Set breakpoint on current line 当前行设置断点
- `setBreakpoint(line)`, `sb(line)` - Set breakpoint on specific line 在特定行上设置断点
- `setBreakpoint('fn()')`, `sb(...)` - Set breakpoint on a first statement in functions body 在函数f的第一行设置断点
- `setBreakpoint('script.js', 1)`, `sb(...)` - Set breakpoint on first line of `script.js` 在 script.js 的第20行设置断点
- `clearBreakpoint('script.js', 1)`, `cb(...)` - Clear breakpoint in `script.js` on line 1 清除断点

**Information**

- `backtrace`, `bt` - Print backtrace of current execution frame 显示当前的调用栈
- `list(5)` - List scripts source code with 5 line context (5 lines before and after) 显示当前执行到的前后5行代码
- `watch(expr)` - Add expression to watch list 把表达式 expr 加入监视列表
- `unwatch(expr)` - Remove expression from watch list 把表达式 expr 从监视列表移除
- `watchers` - List all watchers and their values (automatically listed on each breakpoint) 显示监视列表中所有的表达式和值
- `repl` - Open debugger's repl for evaluation in debugging script's context 在当前上下文打开即时求值环境
- `exec expr` - Execute an expression in debugging script's context 在调试脚本的上下文中执行表达式

**Execution control**

- `run` - Run script (automatically runs on debugger's start) 执行脚本,在第一行暂停
- `restart` - Restart script 重新执行脚本
- `kill` - Kill script 终止当前执行的脚本

**Various**

- `scripts` - List all loaded scripts 显示当前已加载的所有脚本
- `version` - Display V8's version 显示v8版本

参考网站：https://nodejs.org/api/debugger.html

https://www.cnblogs.com/axl234/p/6504336.htm

