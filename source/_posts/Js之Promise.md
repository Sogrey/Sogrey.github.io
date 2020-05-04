---
title: Js之Promise
date: 2020-04-28 10:14:21
tags: [JavaScript,JS,Promise]
categories: JavaScript
comments: true
toc: true
---

## promise是什么？

- promise是一个对象，对象和函数的区别就是对象可以保存状态，有3个状态分别是：等待态（默认） 成功态 失败态，函数不可以（闭包除外）
- 并未剥夺函数return的能力，因此无需层层传递callback，进行回调获取数据
- 代码风格，容易理解，便于维护
- 多个异步等待合并便于解决

ES6 原生提供了 Promise 对象。

<!-- more -->

## promise 之前如何异步操作


## promise 如何异步操作

> 使用回调函数存在的问题在于他剥夺了我们使用 `return` 和 `throw` 这些关键字的能力。而 Promise 很好地解决了这一切。

每个promise实例都有一个`.then`方法。`resolve`（成功）,`reject`（失败）。
`resolve`,`reject`是自己定义的，你需要他成功或者失败，要先调用的是谁？一旦成功了就不能失败；如果你手动抛出一个异常那就注定会进失败的结果了；

``` JS
let  promise = new Promise((resolve,reject) => {
   //耗时异步操作
   resolve('成功'); reject('失败');
}).then(data =>{    //成功
    console.log(data)
},err =>{   //失败
    console.log('err',err)
});
//成功
```

其中：

1. resolve作用是，将Promise对象的状态从“未完成”变为“成功”（即从 pending 变为 resolved），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；reject作用是，将Promise对象的状态从“未完成”变为“失败”（即从 pending 变为 rejected），在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去。

2. promise有三个状态：<br>   1、pending[待定]初始状态<br>   2、fulfilled[实现]操作成功<br>   3、rejected[被否决]操作失败<br>   当promise状态发生改变，就会触发then()里的响应函数处理后续步骤；<br>   promise状态一经改变，不会再变。

3. Promise对象的状态改变，只有两种可能：<br>   从pending变为fulfilled<br>   从pending变为rejected。<br>   这两种情况只要发生，状态就凝固了，不会再变了。


## 参考

- [**Promise** - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise)
- [Javascript 中的神器——Promise](https://www.jianshu.com/p/063f7e490e9a)
- [Promise @廖雪峰](https://www.liaoxuefeng.com/wiki/1022910821149312/1023024413276544)
- [promise @王云飞_小四_wyunfei](https://www.jianshu.com/p/1b63a13c2701)
