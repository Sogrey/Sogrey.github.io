---
title: SpringBoot支持HTTPS
date: 2020-12-17 00:01:15
tags: [Java,Spring boot]
categories: Java
comments: true
toc: true
---


这里讲的是 Spring Boot 内嵌式 Server 打 jar 包运行的方式，打 WAR 包部署的就不存在要 Spring Boot 支持 HTTPS 了，只需去外部对应的 Server 配置。
<!--more-->
## HTTPS

`HTTPS` （全称：Hyper Text Transfer Protocol over SecureSocket Layer），是以安全为目标的 HTTP 通道，在HTTP的基础上通过传输加密和身份认证保证了传输过程的安全性。HTTPS 在HTTP 的基础下加入[SSL](https://baike.baidu.com/item/SSL/320778) 层，HTTPS 的安全基础是 SSL，因此加密的详细内容就需要 SSL。 HTTPS 存在不同于 HTTP 的默认端口及一个加密/身份验证层（在 HTTP与 [TCP](https://baike.baidu.com/item/TCP/33012) 之间）。这个系统提供了身份验证与加密通讯方法。它被广泛用于万维网上安全敏感的通讯，例如交易支付等方面。


## SpringBoot支持Https

### 第一步：获取证书

要获取一个https证书，本地我们可以借助 Java 自带的 JDK 管理工具 keytool 来生成一个免费的 https 证书，也可以到腾讯云免费申请一个。

使用JDK生成，首先需要安装JDK，配置好java环境变量。

`cmd`进入命令行输入`keytool`回车有输出不报错就行。

执行命令：
``` bash
keytool -genkey -alias spring -keypass 123456 -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 365 -keystore E:/spring.keystore -storepass 654321
```

> E:/spring.keystore  -> E:/spring.p12 ??

其中几个参数的解释如下：

1. `-alias` 指定别名
2. `-keypass`此别名对应密码
3. `-storetype` 指定密钥仓库类型
4. `-keyalg` 生证书的算法名称，RSA是一种非对称加密算法
5. `-keysize` 证书大小
6. `-keystore` 生成的证书文件的存储路径
7. `-validity` 证书的有效期

依次填写证书相关的信息:

![keytool生成ssl证书](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/keytool生成ssl证书.png)

在E盘下就生成一个文件`spring.keystore`。

### 第二步：springboot项目中引入https

将刚刚生成的证书文件拷贝到项目中的`resources`目录中，修改`application.properties`文件，添加`HTTPS`支持。

```
server.ssl.key-store=spring.keystore
server.ssl.key-store-password=654321
server.ssl.keyStoreType=PKCS12
server.ssl.keyAlias:spring
```

配置完成后就启动可以启动项目了。

部署完成后使用工具：[SSL证书验证,SSL检测安装工具](https://link.zhihu.com/?target=https%3A//infinisign.com/tools/sslcheck/%3Flang%3Dcn) 来检查SSL是否部署成功。

## 配置好Https兼容http

配置好Https发现http就不好用了，此时访问http地址是不成功的，如果需要支持支持HTTP重定向到HTTPS，需要在配置类中配置一个`TomcatEmbeddedServletContainerFactory` bean:

``` java
@Bean
public EmbeddedServletContainerFactory servletContainer() {
  TomcatEmbeddedServletContainerFactory tomcat = new TomcatEmbeddedServletContainerFactory() {
      @Override
      protected void postProcessContext(Context context) {
        SecurityConstraint securityConstraint = new SecurityConstraint();
        securityConstraint.setUserConstraint("CONFIDENTIAL");
        SecurityCollection collection = new SecurityCollection();
        collection.addPattern("/*");
        securityConstraint.addCollection(collection);
        context.addConstraint(securityConstraint);
      }
  };
  tomcat.addAdditionalTomcatConnectors(initiateHttpConnector());
  return tomcat;
}

private Connector initiateHttpConnector() {
  Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
  connector.setScheme("http");
  connector.setPort(8081);
  connector.setSecure(false);
  connector.setRedirectPort(8080);
  return connector;
}
```

此时访问http://localhost:8081 会自动跳转到https://localhost:8080  表明配置成功。

## 参考

- [Spring Boot 支持 HTTPS 如此简单，So easy!](https://blog.csdn.net/u013322876/article/details/95594859)
- [Spring Boot 使用SSL-HTTPS](https://zhuanlan.zhihu.com/p/31385073)
- [SpringBoot系列——启用https](https://www.cnblogs.com/huanzi-qch/p/12133872.html)
- [SpringBoot配置HTTPS,并实现HTTP访问自动转HTTPS访问](https://www.jianshu.com/p/8d4aba3b972d)