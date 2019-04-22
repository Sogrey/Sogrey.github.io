---
title: 前端调试之把玩console
date: 2019-03-15 12:02:58
tags: [前端]
categories: 前端
comments: true
toc: true
---

Console 对象用于 JavaScript 调试。

JavaScript 原生中默认是没有 Console 对象,这是宿主对象（也就是游览器）提供的内置对象。 用于访问调试控制台, 在不同的浏览器里效果可能不同。

Console 对象常见的两个用途：

- 显示网页代码运行时的错误信息。
- 提供了一个命令行接口，用来与网页代码互动。

<!--more-->

## Console 对象方法

### assert()   
 ssert方法接受两个参数，第一个参数是表达式，第二个参数是字符串。只有当第一个参数为false，才会输出第二个参数，否则不会有任何结果。 

实例
``` js
console.assert(true === false, "判断条件不成立")
// Assertion failed: 判断条件不成立
```

###  clear()      
清除当前控制台的所有输出，将光标回置到第一行。   

``` js
console.clear()
```
### count()     
用于计数，输出它被调用了多少次。   
```js 
(function() { 
    for (var i = 0; i < 5; i++) {  
    	console.count('count'); 
    }
})();
```
### error()      

 输出信息时，在最前面加一个红色的叉，表示出错，同时会显示错误发生的堆栈。

``` js
console.error("Error: %s (%i)", "Server is not responding",500)
```
### group()        
用于将显示的信息分组，可以把信息进行折叠和展开。      
``` js
console.group('第一层');
console.group('第二层');
console.log('error');
console.error('error');
console.warn('error');
console.groupEnd();
console.groupEnd();
```
### groupCollapsed() 
与console.group方法很类似，唯一的区别是该组的内容，在第一次显示时是收起的（collapsed），而不是展开的。 
``` js
console.groupCollapsed('第一层'); 
console.groupCollapsed('第二层');
console.log('error');
console.error('error');
console.warn('error');
console.groupEnd();
console.groupEnd();
```
### groupEnd()     
结束内联分组   
``` js
console.group('Group One');
console.group('Group Two');
// some code
console.groupEnd(); // Group Two 结束 
console.groupEnd(); // Group One 结束
```
### info()   
onsole.log 别名，输出信息      
``` js
console.info("runoob")
```
### log()       
输出信息             
``` js
console.log("runoob")
```
常见的占位符 `%o` (这是字母o，不是0)，它接受对象，`%s` 接受字符串，`%d` 表示小数或整数。

``` js
console.log('I like %s but I do not like %s.', 'Skittles', 'pus');
```

另一个有趣的是 `%c`，这可能与你所想不太相同，它实际上是CSS值的占位符。使用%c占位符时，对应的后面的参数必须是CSS语句，用来对输出内容进行CSS渲染。常见的输出方式有两种：`文字样式、图片输出`。

``` js
console.log('I am a %cbutton', 'color: white; background-color: orange; padding: 2px 5px; border-radius: 2px');
```



### table() 

将复合类型的数据转为表格显示。                      
``` js 
var arr= [ 
         { num: "1"},
         { num: "2"}, 
         { num: "3" }
    ];
console.table(arr);

var obj= {
     a:{ num: "1"},
     b:{ num: "2"},
     c:{ num: "3" }
};
console.table(obj);
```
### time()  
 计时开始      
``` js
console.time('计时器1');
for (var i = 0; i < 100; i++) {
  for (var j = 0; j < 100; j++) {}
}
console.timeEnd('计时器1');
console.time('计时器2');
for (var i = 0; i < 1000; i++) {
  for (var j = 0; j < 1000; j++) {}
}
console.timeEnd('计时器2');
```
### timeEnd()  
计时结束          
``` js
console.time('计时器1');
for (var i = 0; i < 100; i++) {
  for (var j = 0; j < 100; j++) {}
}
console.timeEnd('计时器1');
console.time('计时器2');
for (var i = 0; i < 1000; i++) {
  for (var j = 0; j < 1000; j++) {}
}
console.timeEnd('计时器2');
```

### trace()        
追踪函数的调用过程 
``` js
function d(a) { 
  console.trace();
  return a;
}
function b(a) { 
  return c(a);
}
function c(a) { 
  return d(a);
}
var a = b('123');
```

### warn()   
输出警告信息   
``` js
console.warn("警告")
```



最后附上 console 的正则匹配，若有提议欢迎留言。

`console.(clear|log|info|error|warn|groupEnd|group|dirxml|dir|assert|timeEnd|time|profileEnd|profile|count|table)([\(][^\)]+[\)]|[\(][\)]) `

> 如果参数中包含括弧可能会匹配不准。

http://www.runoob.com/w3cnote/javascript-console-object.html

https://www.cnblogs.com/alantao/p/5859358.html