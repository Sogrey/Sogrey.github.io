---
title: JS中apply()与call()的区别
date: 2019-03-18 15:44:49
tags: [JS]
categories: JS
comments: true
toc: true
---

# JS中apply()与call()的区别

JavaScript中的每一个Function对象都有一个apply()方法和一个call()方法，它们的语法分别为： 

```js
/*apply()方法*/
function.apply(thisObj[, argArray])

/*call()方法*/
function.call(thisObj[, arg1[, arg2[, [,...argN]]]]);
```

<!--more-->

## 定义

- apply：调用一个对象的一个方法，用另一个对象替换当前对象。例如：B.apply(A, arguments);即A对象应用B对象的方法。
- call：调用一个对象的一个方法，用另一个对象替换当前对象。例如：B.call(A, args1,args2);即A对象调用B对象的方法。



**它们的共同之处：**

都“可以用来代替另一个对象调用一个方法，将一个函数的对象上下文从初始的上下文改变为由thisObj指定的新对象”。

**它们的不同之处：**

- apply：最多只能有两个参数——新this对象和一个数组argArray。如果给该方法传递多个参数，则把参数都写进这个数组里面，当然，即使只有一个参数，也要写进数组里。如果argArray不是一个有效的数组或arguments对象，那么将导致一个TypeError。如果没有提供argArray和thisObj任何一个参数，那么Global对象将被用作thisObj，并且无法被传递任何参数。
- call：它可以接受多个参数，第一个参数与apply一样，后面则是一串参数列表。这个方法主要用在js对象各方法相互调用的时候，使当前this实例指针保持一致，或者在特殊情况下需要改变this指针。如果没有提供thisObj参数，那么 Global 对象被用作thisObj。 

实际上，apply和call的功能是一样的，只是传入的参数列表形式不同。

### 一般用法

```js
function add(a,b){
  return a+b;  
}
function sub(a,b){
  return a-b;  
}
var a1 = add.apply(sub,[4,2]);　　//sub调用add的方法
var a2 = sub.apply(add,[4,2]);
console.log(a1);  //6
console.log(a2);  //2

/*call的用法*/
var a1 = add.call(sub,4,2);
console.log(a1);
```

### 继承

```js
function Animal(name){
  this.name = name;
  this.showName = function(){
        alert(this.name);    
    }    
}

function Cat(name){
  Animal.apply(this,[name]);    
}

var cat = new Cat("咕咕");
cat.showName();

/*call的用法*/
Animal.call(this,name);
```

多重继承 :

```js
function Class10(){
  this.showSub = function(a,b){
        alert(a - b);
    }   
}

function Class11(){
  this.showAdd = function(a,b){
        alert(a + b);
    }  
}

function Class12(){
  Class10.apply(this);
  Class11.apply(this);   
  //Class10.call(this);
  //Class11.call(this);  
}

var c2 = new Class12();
c2.showSub(3,1);    //2
c2.showAdd(3,1);    //4
```

## **apply的一些其他巧妙用法**

(1) Math.max 可以实现得到数组中最大的一项： 

因为Math.max不支持`Math.max([param1,param2])`也就是数组，但是它支持`Math.max(param1,param2...)`，所以可以根据apply的特点来解决 `var max=Math.max.apply(null,array)`，这样就轻易的可以得到一个数组中的最大项（apply会将一个数组转换为一个参数接一个参数的方式传递给方法）

这块在调用的时候第一个参数给了null，这是因为没有对象去调用这个方法，我只需要用这个方法帮我运算，得到返回的结果就行，所以直接传递了一个null过去。

用这种方法也可以实现得到数组中的最小项：Math.min.apply(null,array)

(2）Array.prototype.push可以实现两个数组的合并 

同样push方法没有提供push一个数组，但是它提供了push(param1,param2...paramN)，同样也可以用apply来转换一下这个数组 

```js
var arr1=new Array("1","2","3");
var arr2=new Array("4","5","6");
Array.prototype.push.apply(arr1,arr2);    //得到合并后数组的长度，因为push就是返回一个数组的长度
```

> 注意：apply 传入参数长度是有限制的，超出限制会报出：
> ```
> Uncaught RangeError: Maximum call stack size exceeded
> ```
> 这是只能使用传统方法 for 循环来解决。