---
title: 使用Maven搭建spring boot项目（下）
date: 2020-11-29 12:06:01
tags: [Java,Spring boot,Maven,Myeclipse]
categories: Spring boot
comments: true
toc: true
---

[上节](/article/使用Maven搭建spring-boot项目/)我们搭建了一个简单的Spring boot web项目，要想运行起来还需加入Spring boot，现在安排。

<!--more-->

## 在pom.xml中引入相关依赖

1. 引入`spring-boot-start-parent`，spring官方的叫stater poms，它可以提供dependency management，也就是依赖管理，引入以后在声明其它dependency的时候就不需要version了。

   ```xml
   <parent>  
        <groupId>org.springframework.boot</groupId>  
        <artifactId>spring-boot-starter-parent</artifactId>  
        <version>1.5.3.RELEASE</version>  
   </parent>
   ```

2. 引入`spring-boot-starter-web`，spring官方解释spring-boot-start-web包含了spring webmvc和tomcat等web开发的特性。

   ``` xml
   <dependencies>  
         <dependency>  
             <groupId>org.springframework.boot</groupId>  
              <artifactId>spring-boot-starter-web</artifactId>  
          </dependency>  
   </dependencies> 
   ```

3. 引入`spring-boot-maven-plugin`,用于启动spring，否则是无法启动的。如果使用maven的`spring-boot:run`的话就不需要此配置。

   ``` xml
   <build>  
         <plugins>  
               <plugin>  
                   <groupId>org.springframework.boot</groupId>  
                  <artifactId>spring-boot-maven-plugin </artifactId>  
             </plugin>  
          </plugins>  
   </build>
   ```

完整pom.xml见https://github.com/Sogrey/SpringBootDemo/blob/main/pom.xml

## 添加java相关代码

1. 创建启动类，然后在启动类声明让spring boot自动给我们配置spring需要的配置。

   ``` java
   package top.sogrey;
   
   import org.springframework.boot.SpringApplication;
   import org.springframework.boot.autoconfigure.SpringBootApplication;
   import org.springframework.stereotype.Controller;
   import org.springframework.web.bind.annotation.RequestMapping;
   import org.springframework.web.bind.annotation.ResponseBody;
   
   @SpringBootApplication // Spring Boot项目的核心注解，主要目的是开启自动配置
   public class HelloApplication {   
   
       // 在main方法中启动一个应用，即：这个应用的入口
       public static void main(String[] args) {
           SpringApplication.run(HelloApplication.class, args);
       }
       
   }
   ```

   其中：

   其中`@SpringBootApplication`声明让spring boot自动给程序进行必要的配置，等价于以默认属性使用`@Configuration`，`@EnableAutoConfiguration`和`@ComponentScan`。

2. 添加控制器

   ``` java
   package top.sogrey.controller;
   
   import org.springframework.stereotype.Controller;
   import org.springframework.web.bind.annotation.RequestMapping;
   import org.springframework.web.bind.annotation.ResponseBody;
   
   @Controller // 标明这是一个SpringMVC的Controller控制器
   @RequestMapping(value = "/api")
   public class HelloController {
   
   	@RequestMapping("/")
       @ResponseBody
       public String hello() {
           return "hello world";
       }
       
       @RequestMapping("/hello")
       @ResponseBody
       public String sayHello(String name) {
           return "hello "+name;
       }
   
   }
   ```

## 运行

两种运行方式：

1. 右键`Run As` -> `Java Application`。之后打开浏览器输入地址：

   http://localhost:10111/api/

   http://localhost:10111/api/hello?name=Sogrey  //带参数

   试试看。

1. 第二种方式右键`Run as` –>`Maven build` – 在Goals里输入`spring-boot:run` ,然后Apply,最后点击Run。

github地址：https://github.com/Sogrey/SpringBootDemo.git