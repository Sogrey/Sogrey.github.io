---
title: json转树状结构（收集）
author: Sogrey
categories: JavaScript
date: 2017-12-09 10:48:07
tags: [JavaScript,JSON]
---

> 后话： 现有新的实现方案，基于java8 Stream ，不妨看下？
>
> [使用java8中Stream轻松遍历树形结构](https://sogrey.top/article/%E4%BD%BF%E7%94%A8java8%E4%B8%ADStream%E8%BD%BB%E6%9D%BE%E9%81%8D%E5%8E%86%E6%A0%91%E5%BD%A2%E7%BB%93%E6%9E%84/)

一切都源于项目需求。近期web项目中需要这样的功能：将json数据转为树级结构，json的数据结构如下：

``` javascript

  [
    {
      "id": "1",
      "pId": "0",
      "value": "水电站项目"
    },
    {
      "id": "2",
      "pId": "1",
      "value": "项目一标段"
    },
    {
      "id": "3",
      "pId": "1",
      "value": "项目二标段"
    }
  ]

```

<!-- more -->


于是开始百度，找到如下解决方案：

* 方案一

``` javascript

function toTree(data) {
  // 删除 所有 children,以防止多次调用
  data.forEach(function(item) {
    delete item.children;
  });

  // 将数据存储为 以 id 为 KEY 的 map 索引数据列
  var map = {};
  data.forEach(function(item) {
    map[item.id] = item;
  });

  var val = [];
  data.forEach(function(item) {
    // 以当前遍历项，的pid,去map对象中找到索引的id
    var parent = map[item.pId];

    // 好绕啊，如果找到索引，那么说明此项不在顶级当中,那么需要把此项添加到，他对应的父级中
    if (parent) {
      (parent.children || (parent.children = [])).push(item);
    } else {
      //如果没有在map中找到对应的索引ID,那么直接把 当前的item添加到 val结果集中，作为顶级
      val.push(item);
    }
  });

  return val;
}

```

这个方案却也适合，只是他只能适用于 `id-pId` 这种，要适配 其他 像 `dataId-parentId` 这种就需要将上面代码中的 `id`改为`dataId`，`pId`改为`parentId`。

之后又发现了另一种方案。

* 方案二

``` javascript

/** 
 * json格式转树状结构 
 * @param   {json}      json数据 
 * @param   {String}    id的字符串 
 * @param   {String}    父id的字符串 
 * @param   {String}    children的字符串 
 * @return  {Array}     数组 
 */  
function transData(a, idStr, pidStr, chindrenStr){  
    var r = [], hash = {}, id = idStr, pid = pidStr, children = chindrenStr, i = 0, j = 0, len = a.length;  
    for(; i < len; i++){  
        hash[a[i][id]] = a[i];  
    }  
    for(; j < len; j++){  
        var aVal = a[j], hashVP = hash[aVal[pid]];  
        if(hashVP){  
            !hashVP[children] && (hashVP[children] = []);  
            hashVP[children].push(aVal);  
        }else{  
            r.push(aVal);  
        }  
    }  
    return r;  
} 

```

来自：[json转树状结构（js）](http://rockyuse.iteye.com/blog/1541308)

这样使用：`var jsonDataTree = transData(jsonData, 'id', 'pid', 'chindren');  `,其中 参数一是json数据对象，后三个参数分别指明了 `id`、 `pId` 以及其子集 `chindren`，很好解决了方案一的不足.

借于方案二的启发，何不将方案一改造改造，于是就有了：

``` javascript

/** 
 * json格式转树状结构 
 * @param   {json}      json数据 
 * @param   {String}    id的字符串 默认值"id"
 * @param   {String}    父id的字符串 默认值"pId"
 * @param   {String}    children的字符串 默认值"children"
 * @return  {Array}     数组 
 */  
function toTree(data,idStr="id",pIdStr="pId",chindrenStr="children") {
  // 删除 所有 children,以防止多次调用
  data.forEach(function(item) {
    delete item[chindrenStr];
  });

  // 将数据存储为 以 id 为 KEY 的 map 索引数据列
  var map = {};
  data.forEach(function(item) {
    map[item[idStr]] = item;
  });

  var val = [];
  data.forEach(function(item) {
    // 以当前遍历项，的pid,去map对象中找到索引的id
    var parent = map[item[pIdStr]];

    // 好绕啊，如果找到索引，那么说明此项不在顶级当中,那么需要把此项添加到，他对应的父级中
    if (parent) {
      (parent[chindrenStr] || (parent[chindrenStr] = [])).push(item);
    } else {
      //如果没有在map中找到对应的索引ID,那么直接把 当前的item添加到 val结果集中，作为顶级
      val.push(item);
    }
  });

  return val;
}  

```

其中后三个参数设置默认值分别是 `id-pId-children`，像开题的那段json刚好满足就省略后三个参数可以这样调用：

``` javascript
var jsonData = eval('[{"id":"1","pId":"0","value":"水电站项目"},{"id":"2","pId":"1","value":"项目一标段"},{"id":"3","pId":"1","value":"项目二标段"}]'); 
var jsonDataTree = toTree(jsonData); 
console.log(jsonDataTree); 

```

输出如下：

``` javascript
[
    {
        "id": "1", 
        "pId": "0", 
        "value": "水电站项目", 
        "children": [
            {
                "id": "2", 
                "pId": "1", 
                "value": "项目一标段"
            }, 
            {
                "id": "3", 
                "pId": "1", 
                "value": "项目二标段"
            }
        ]
    }
]

``` 

## 参考

* [java、js中实现无限层级的树形结构（类似递归）](http://www.cnblogs.com/azhqiang/p/4169534.html)
* [json转树状结构（js）](http://rockyuse.iteye.com/blog/1541308)