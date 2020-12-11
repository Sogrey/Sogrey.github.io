---
title: 使用Maven搭建spring boot项目
date: 2020-11-28 10:06:01
tags: [Java,Spring boot,Maven,Myeclipse]
categories: Java
comments: true
toc: true
---

准备工具：

- MyEclipse CI 2019.4.0
- JDK1.8
- Tomcat 8.5

MyEclipse 和 JDK 的下载安装就不细说了，自行百度，一带而过。

<!--more-->

## MyEclipse使用Maven搭建spring boot项目

1. `File`->`New`->`Project`->`Maven Project`

   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME1.png)

2. `Next`, 选择`Use default Workspace location`。

   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME2.png)

3. `Next`, 选择`maven-archetype-webapp`创建一个webapp目录结构的项目

   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME3.png)

4. 填`Group Id`，`Artifact Id`，和`Package，点击`Finish`

   - GroupId：一般是公司名或组织名。
   - ArtifactId：一般是project名。
   - Packaging：打包类型，jar/war/rar/ear/pom等，默认是jar。
   - Version：版本号，GroupId+ArtifactId+Packaging+Version构成项目的唯一标识。

   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME4.png)

5. 等待MyEclipse创建项目,完成后，文件目录结构如下

   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME5.png)

## Eclipse暂时通过Spring Initializr官网快速构建spring boot工程

1. 使用浏览器打开： http://start.spring.io
1. 填写项目相关信息，选取依赖，然后生成项目
1. 解压项目，在Eclipse导入Maven工程


![create-spring-boot-by-Spring-Initializr](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-Spring-Initializr.png)

到此，一个简单的Spring boot web项目就初步搭建了，要想运行起来还需加入Spring boot，[下节](/article/使用Maven搭建spring-boot项目（下）/)安排。

## 解决一些异常

1. 创建完成后，发现index.jsp报错，打开index.jsp，报错如下

   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME6.png)
   
   在项目上右键->`build path`->`AddLibrary`,选择MyEclipse Server Library,Next后，选择一个Tomcat，Finish。
   
   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME8.png)
   
2. pom.xml报错,有小红叉

   项目上右键选`maven`->`Update Project`

   ![create-spring-boot-by-ME](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/create-spring-boot-by-ME9.png)


