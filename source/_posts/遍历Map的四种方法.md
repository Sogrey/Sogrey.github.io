---
title: 遍历Map的四种方法
date: 2018-04-04 11:05:35
tags: [Java,Map]
categories: Java
comments: true
toc: true
---

* 第一种：普遍使用，二次取值

``` java
  System.out.println("通过Map.keySet遍历key和value：");
  for (String key : map.keySet()) {
   System.out.println("key= "+ key + " and value= " + map.get(key));
  }
```
 
* 第二种


``` java
  System.out.println("通过Map.entrySet使用iterator遍历key和value：");
  Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
  while (it.hasNext()) {
   Map.Entry entry = it.next();
   System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
  }
```
 
* 第三种：推荐，尤其是容量大时


``` java
  System.out.println("通过Map.entrySet遍历key和value");
  for (Map.Entry entry : map.entrySet()) {
   System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
  }
```

* 第四种


``` java
  System.out.println("通过Map.values()遍历所有的value，但不能遍历key");
  for (String v : map.values()) {
   System.out.println("value= " + v);
  }
```