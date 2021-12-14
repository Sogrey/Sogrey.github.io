---
title: JS操作iframe元素
date: 2021-12-14 23:39:03
tags: [JS]
categories: JS
comments: true
toc: true
---

## 1. 获得iframe的window对象

存在跨域访问限制。

- chrome：iframeElement. contentWindow
- firefox：iframeElement.contentWindow
- ie6：iframeElement.contentWindow

一些浏览器可以通过iframeElement.contentDocument.parentWindow获得iframe的window对象。但经过测试firefox、chrome的element.contentDocument对象没有parentWindow属性。

``` js
function getIframeWindow(element){		
    return  element.contentWindow;
    //return  element.contentWindow || element.contentDocument.parentWindow;
}
```
## 2. 获得iframe的document对象
存在跨域访问限制。

- chrome：iframeElement.contentDocument
- firefox：iframeElement.contentDocument
- ie：element.contentWindow.document

> 备注：ie没有iframeElement.contentDocument属性。

``` js
var getIframeDocument = function(element) {
    return  element.contentDocument || element.contentWindow.document;
};
```
## 3. iframe中获得父页面的window对象
存在跨域访问限制。

- 父页面：window.parent
- 顶层页面：window.top

> 适用于所有浏览器

## 4. 获得iframe在父页面中的html标签
存在跨域访问限制。

window.frameElement（类型：HTMLElement）

> 适用于所有浏览器

## 5. iframe的onload事件

非ie浏览器都提供了onload事件。例如下面代码在ie中是不会有弹出框的。
``` js
var ifr = document.createElement('iframe');
ifr.src = 'http://www.b.com/index.php';
ifr.onload = function() {
    alert('loaded');
};
document.body.appendChild(ifr);
```
但是ie却又似乎提供了onload事件，下面两种方法都会触发onload

方法一：
``` html
<iframe  onload="alert('loaded');"  src="http://www.b.com/index.php"></iframe>
```
方法二：
``` js
//只有ie才支持为createElement传递这样的参数
var ifr = document.createElement('<iframe  onload="alert('loaded');" src="http://www.b.com/index.php"></iframe>');
document.body.appendChild(ifr);
```
由于iframe元素包含于父级页面中，因此以上方法均不存在跨域问题。

实际上IE提供了onload事件，但必须使用attachEvent进行绑定。
``` js
var ifr = document.createElement('iframe');
ifr.src = 'http://b.a.com/b.php';
if (ifr.attachEvent) {
    ifr.attachEvent('onload',  function(){ alert('loaded'); });
} else {
    ifr.onload  = function() { alert('loaded'); };
}
document.body.appendChild(ifr);
```
## 6. frames

window.frames可以取到页面中的帧(iframe、frame等)，需要注意的是取到的是window对象，而不是HTMLElement。
``` js
var ifr1 = document.getElementById('ifr1');
var ifr1win = window.frames[0];
ifr1win.frameElement === ifr1;   // true
ifr1win === ifr1;    // false
```

## 参考

- [JS操作iframe](https://www.cnblogs.com/rainman/archive/2011/02/16/1956431.html)
- [JS操作iframe元素](https://www.cnblogs.com/html55/p/10163631.html)