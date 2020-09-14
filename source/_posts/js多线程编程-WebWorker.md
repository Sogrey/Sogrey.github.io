---
title: 'js多线程编程-WebWorker'
date: 2020-09-13 22:47:44
tags: [JavaScript,JS,WebWorker]
categories: JavaScript
comments: true
toc: true
---

## 什么是Web Worker


## 如何不引入外部js文件开启子线程



## 浏览器兼容性

[点此查看](https://caniuse.com/?search=WebWorker)

## 遇到问题

### 传输大量数据

## 常见异常

### `Failed to execute 'postMessage' on 'Worker': could not be cloned.`

问题所在：

postMessage中传入了不可clone的参数。比如一些HTML element。因为这些元素即使传过去了（cloned），也无法操作啊！

Web Worker 有以下几个使用注意点[1]。
（1）同源限制
分配给 Worker 线程运行的脚本文件，必须与主线程的脚本文件同源。
（2）DOM 限制
Worker 线程所在的全局对象，与主线程不一样，无法读取主线程所在网页的 DOM 对象，也无法使用document、window、parent这些对象。但是，Worker 线程可以navigator对象和location对象。
（3）通信联系
Worker 线程和主线程不在同一个上下文环境，它们不能直接通信，必须通过消息完成。
（4）脚本限制
Worker 线程不能执行alert()方法和confirm()方法，但可以使用 XMLHttpRequest 对象发出 AJAX 请求。
（5）文件限制
Worker 线程无法读取本地文件，即不能打开本机的文件系统（file://），它所加载的脚本，必须来自网络。


## 参考

1. https://www.cnblogs.com/brokencolor/p/13181106.html


//TODO

- [javascript 多线程Web Worker不引用外部js文件的方法](https://www.cnblogs.com/Cavalry/p/4748072.html)
- https://developer.mozilla.org/zh-CN/docs/Web/API/WorkerGlobalScope/importScripts

https://www.cnblogs.com/yanbigfeg/p/9546599.html

https://www.cnblogs.com/wishyouhappy/p/3766225.html

https://www.cnblogs.com/panmy/p/5764507.html

https://www.cnblogs.com/heshan1992/p/6698069.html

http://www.ruanyifeng.com/blog/2018/07/web-worker.html




https://www.cnblogs.com/brokencolor/p/13181106.html

https://www.cnblogs.com/yanbigfeg/p/9546599.html

https://segmentfault.com/a/1190000012563475  √

https://github.com/CarterLi/ThreadPool.js/blob/gh-pages/index.ts √


https://github.com/pikaz-18/pikaz-webworker

https://github.com/israelss/simple-web-worker

出于某种原因,在WebWorker中运行的完全相同的代码比在主线程上运行的代码要慢得多. (选自：[https://www.jb51.cc/js/429080.html](https://www.jb51.cc/js/429080.html))

如何将大数据传递给Web worker  https://code-examples.net/zh-CN/q/1243f84

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/SharedArrayBuffer