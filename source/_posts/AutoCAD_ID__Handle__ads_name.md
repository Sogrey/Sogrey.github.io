---
title: AutoCAD_ID、指针、句柄和ads_name的区别
date: 2021-01-04 22:30:10
tags: [AutoCad,Cad]
categories: AutoCad
comments: true
toc: true
---

转载自：https://my.oschina.net/u/2930533/blog/759617

![ ](http://static.oschina.net/uploads/space/2016/1017/165317_6Tgq_2930533.png)

<!--more-->

访问实体的特性必须通过对象指针，但是一旦你获得了实体的ID、句柄或者ads_name，都能通过ID作中介而获得对象的指针。其中ID是一个桥梁。句柄是Windows编程一个常用的概念，在ObjectARX编程中一般指AcDbHandle类（也可指Windows编程的界面元素），该类封装了一个64位整形标识符，随DWG文件一同保存。ads_name则是在ADS编程中出现的一个概念，其实际上是一个二维数组，数组元素类型为长整型，在与用户交互的函数中经常用到。

## ID、句柄和 ads_name 具有各自的特点：

1. AcDbObjectId：当dwg图形被打开后,数据库中的实体对象都会在内存中对应一个唯一的id(AcDbObjectId),AcDbObjectId也是与对象相关联的唯一标识符.AcDbObjectId仅存在于其所存在的数据库从内存中产生到数据库被删除之间.如果操作多个dwg,AcDbObjectId在多个数据库之间都是唯一的.
2. AcDbHandle：dwg文件中每一个实体都有一个唯一的标识符,用AcDbHandle表示,在一个AutoCAD中，不能保证每个实体的句柄都唯一。在autoCAD的两个Dwg中同一实体的句柄是相同的。实体的AcDbHandle可以随dwg文件被保存,所以即使dwg未被cad打开,也可以根据句柄搜索dwg文件获取对象信息.
3. AcDbObject对象指针:当一个对象被打开后,AutoCAD会返回指向AcDbObject或其派生类型的应该c++指针,然后就可以采用标准c++类对象的方式对实体进行操作.
4. ads_name：AutoCAd定义的一个数据类型.一般用来保存用户交互过程中成功选择实体的节点,ads_name是不稳定的，仅当你在一旦退出 AutoCAD 或者切换到另一个图形，ads_name 就会丢失.

## ID、指针、句柄和 ads_name 之间具有下面的转换关系：

1. 从 AcDbObjectId 到AcDbObject对象:acdbOpenAcDbObject() 或者 acdbOpenObject() 。
2. 从 AcDbObject 对象到 AcDbObjectId ：所有的数据库常驻对象都继承自 AcDbObjectId 函数能获得所指向对象的 ID。
3. 从AcDbHandle 到 AcDbObjectId ： AcDbDatabase::getAcDbObjectId();
4. 从 AcDbObjectId 到AcDbHandle ：AcDbObjectId::handle() 。
5. 从 AcDbObject 到AcDbHandle ：AcDbObject::getAcDbHandle().
6. 从 ads_name 到 AcDbObjectId ：使用全局函数 acdbGetObjectId()。
7. 从 AcDbObjectId 到 ads_name ：使用全局函数 acdbGetAdsName()。

 