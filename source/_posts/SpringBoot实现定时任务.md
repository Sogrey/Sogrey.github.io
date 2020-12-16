---
title: SpringBoot实现定时任务
date: 2020-12-15 12:07:28
tags: [Java,Spring boot,Scheduled]
categories: Java
comments: true
toc: true
---

Spring 3.0 版本之后自带定时任务，提供了@EnableScheduling注解和@Scheduled注解来实现定时任务功能。

使用SpringBoot创建定时任务非常简单，目前主要有以下三种创建方式：

1. 基于注解（@Scheduled）
2. 基于接口（SchedulingConfigurer） 前者相信大家都很熟悉，但是实际使用中我们往往想从数据库中读取指定时间来动态执行定时任务，这时候基于接口的定时任务就派上用场了。
3. 基于注解设定多线程定时任务

<!--more-->

## 参考

- [SpringBoot使用@Scheduled注解实现定时任务](https://blog.csdn.net/pan_junbiao/article/details/109399280)