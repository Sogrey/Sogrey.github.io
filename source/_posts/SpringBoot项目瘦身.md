---
title: Spring Boot 项目瘦身
author: Sogrey
date: 2020-12-26 23:22:55
tags: [Java,Spring boot]
categories: Java
comments: true
toc: true
---

我们发现Spring Boot用起来非常方便，但是即使新建的空项目打包jar之后也要14M大小，将jar包解压发现`BOOT-INF/lib`大小就占到13.6M.我们对Springboot打包jar瘦身就是从包内将 `lib` 分离出来，因为对于项目而言架构确定后，引入的三方jar包基本就不会变动了；要是有新增库那就将新增的三方库分离出来就好啦。

<!--more-->

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Springboot-lib-size.png)

## 分离出lib依赖三方库

pom.xml文件的build节点 可能是如下：
``` xml
	<build>
		<plugins>
			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<configuration>
					<mainClass>top.sogrey.HelloApplication</mainClass>
					<layout>ZIP</layout>
				</configuration>
			</plugin>
		</plugins>
	</build>
```
分离前我们需要通过常用的打包命令：
```
Maven ckean
Maven install
```
从`target`目录下拿到完整的jar包（14M）,解压，将`BOOT-INF/lib`另存。

## 修改pom.xml配置，编译出不带 lib 文件夹的Jar包

修改后的pom.xml文件的build节点:
``` xml
	<build>
		<plugins>
			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<configuration>
					<mainClass>top.sogrey.HelloApplication</mainClass>
					<layout>ZIP</layout>
					<includes>
						<include>
							<groupId>nothing</groupId>
							<artifactId>nothing</artifactId>
						</include>
					</includes>
				</configuration>
			</plugin>
		</plugins>
	</build>
```
再次执行打包命令得到不带lib的jar包，大小才98k.

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Springboot-lib-size2.png)

这时将之前分离出来的lib目录与不含lib的jar放在同一目录下,最终目录结构如下：

最终目录文件结构是：
```
├── lib   #lib文件夹  
|  ├─ classmate-1.3.3.jar
|  └─ ... # 其他jar包
└── SpringBootDemo-0.0.1-SNAPSHOT.jar
```

执行命令：

``` bash
$ java -Dloader.path=lib -jar SpringBootDemo-0.0.1-SNAPSHOT.jar
```

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/Springboot-lib-size3.png)

完整的jar包启动命令：

``` bash
$ java -jar SpringBootDemo-0.0.1-SNAPSHOT-FULL.jar
```


## 参考

- [Spring Boot 项目瘦身指南，瘦到不可思议！](https://mp.weixin.qq.com/s/9CuGyrF5EGigxFmOhZtC4g)
