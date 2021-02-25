---
title: Promise.all和Promise.allSettled的区别
date: 2021-02-24 23:33:53
tags: [JS,Promise]
categories: JS
comments: true
toc: true
---

一句话概括Promise.allSettled和Promise.all的最大不同：**Promise.allSettled永远不会被reject**。

<!--more-->

转自：[Promise.all和Promise.allSettled的区别](https://segmentfault.com/a/1190000023413699)

## 解决Promise.all的痛点

当需要处理多个Promise并行时，大多数情况下Promise.all用起来是非常顺手的，比如下面这样

```js
const delay = n => new Promise(resolve => setTimeout(resolve, n));

const promises = [
  delay(100).then(() => 1),
  delay(200).then(() => 2),
  ]

Promise.all(promises).then(values=>console.log(values))
// 最终输出： [1, 2]
```

可是，是一旦有一个promise出现了异常，被reject了，情况就会变的麻烦。

```js
const promises = [
  delay(100).then(() => 1),
  delay(200).then(() => 2),
  Promise.reject(3)
  ]

Promise.all(promises).then(values=>console.log(values))
// 最终输出： Uncaught (in promise) 3

Promise.all(promises)
.then(values=>console.log(values))
.catch(err=>console.log(err))
// 加入catch语句后，最终输出：3
```

尽管能用catch捕获其中的异常，但你会发现其他执行成功的Promise的消息都丢失了，仿佛石沉大海一般。

要么全部成功，要么全部重来，这是Promise.all本身的强硬逻辑，也是痛点的来源，不能说它错，但这的确给Promise.allSettled留下了立足的空间。

假如使用Promise.allSettled来处理这段逻辑会怎样呢?

```js
const promises = [
  delay(100).then(() => 1),
  delay(200).then(() => 2),
  Promise.reject(3)
  ]

Promise.allSettled(promises).then(values=>console.log(values))
// 最终输出： 
//    [
//      {status: "fulfilled", value: 1},
//      {status: "fulfilled", value: 2},
//      {status: "rejected", value: 3},
//    ]
```

可以看到所有promise的数据都被包含在then语句中，且每个promise的返回值多了一个status字段，表示当前promise的状态，没有任何一个promise的信息被丢失。

因此，当用Promise.allSettled时，我们只需专注在then语句里，当有promise被异常打断时，我们依然能妥善处理那些已经成功了的promise，不必全部重来。

## 当前大环境对Promise.allSettled的支持

nodejs从[v12.9.0](https://nodejs.org/en/blog/release/v12.9.0/)开始加入了对Promise.allSettled的支持，主流浏览器们也各自在2019年发布的版本中支持了此方法，这意味着你已经可以放心大胆的使用了。

[![promise-allsettled.png](https://image-static.segmentfault.com/292/869/2928695017-5f20c43ed364c_articlex)](https://caniuse.com/?search=Promise.allSettled)

对于那些不支持此方法的环境，你可以直接引用开源社区中实现了此方法的npm包：

- [promise.allsettled](https://www.npmjs.com/package/promise.allsettled)
- [promise-settle](https://www.npmjs.com/package/promise-settle)
- [promise-all-settled](https://www.npmjs.com/package/promise-all-settled)
- [es2015-promise.allsettled](https://www.npmjs.com/package/es2015-promise.allsettled)

或者，你可以直接基于Promise.all写一个polyfill，给你的项目打上补丁：

```
if (Promise && !Promise.allSettled) {
  Promise.allSettled = function (promises) {
    return Promise.all(promises.map(function (promise) {
      return promise.then(function (value) {
        return { state: 'fulfilled', value: value };
      }).catch(function (reason) {
        return { state: 'rejected', reason: reason };
      });
    }));
  };
}
```

## 结语

Promise.allSettled是对Promise.all的一种补充，当面对多个promise并行时，它额外提供了一种处理方式，解决了当多个promise并行时reject的出现会伴随着其他promise数据丢失的问题。



