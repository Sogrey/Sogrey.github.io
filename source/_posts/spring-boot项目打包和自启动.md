---
title: spring-boot项目打包和自启动
date: 2020-11-30 15:04:27
tags: [Java,Spring boot,Maven,Myeclipse,winsw]
categories: Spring boot
comments: true
toc: true
---

springboot的打包方式有很多种。有打成war的，有打成jar的，也有直接提交到github，通过jekins进行打包部署的。这里主要介绍如何打成jar进行部署。不推荐用war，因为springboot适合前后端分离，打成jar进行部署更合适。

<!--more-->

## spring-boot项目打包

1. 在application.properties当中配置端口

   ```
   server.port=8080
   ```

2. pom.xml添加配置，已经配置过可忽略

   ``` xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <!--配置主类入口-->
                    <mainClass>top.Sogrey.MainApplication</mainClass>
                </configuration>
            </plugin>
        </plugins>
    </build>
   ```

3. 项目右键->`Run As`->`Maven clean` 先清理

4. 项目右键->`Run As`->`Maven install` Maven执行打包

   ![spring-boot-项目打包](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/spring-boot-项目打包.png)

   等待出现`BUILD SUCCESS`字样，打包成功，在项目根目录`target`下查看生成的`jar`文件。

## 运行jar包

执行命令：

``` bash
java -jar myProject.jar
```

## 添加到系统自启动

### Windows

准备工具：[winsw](https://github.com/winsw/winsw/releases),是一个可以将任何应用程序注册成服务的软件

1. 将下载的`WinSW.NET4.exe`与springboot项目打包的jar包（比如:`myProject.jar`）放在同一个文件夹中，并将`WinSW.NET4.exe`重命名为与jar文件同名,比如：`myProject.exe`。
2. 同目录下创建同名的xml文件,比如，输入内容：

   ``` xml
    <configuration>
        <!--安装成Windows服务后的服务名-->
        <id>myProjectServiceID</id>
        <!--显示的服务名称-->
        <name>myProjectServiceName</name>
        <!--对服务的描述-->
        <description>此处可填写该服务的描述</description>
        <!--这里写java的路径，如何配置了环境变量直接写"java"就行-->
        <executable>java</executable>
        <!--Xmx256m 代表堆内存最大值为256MB -jar后面的是项目名-->
        <arguments>-Xmx256m -jar myProject.jar</arguments>
        <!--日志模式-->
        <logmode>rotate</logmode>
    </configuration>
   ```

3. cmd到当前目录下，执行安装命令

   ``` cmd
   myProject.exe install
   ```

4. 命令提示符界面输入启动服务命令

   ``` cmd
   net start myProjectServiceName
   ```

5. 打开系统服务功能：运行——输入`services.msc`，即可看见自己命名的服务`myProjectServiceName`,自启动就好了，可重启系统再次查看系统服务功能。

6. 删除服务。既然启动了服务，我们也可以删除他，同样是两步：

   ``` cmd
   net stop myProjectServiceName #停止运行服务
   myProject.exe uninstall #删除服务
   ```

7. 一键部署命令：

   ``` cmd
   #例如myProjectStart.bat内容如下：
   myProject.exe install
   net start myProjectServiceName

   #例如myProjectStop.bat内容如下：
   net stop myProjectServiceName
   myProject.exe uninstall
   ```
### Linux

1. 开启后台自执行

命令： `nohup` 详细文档说明可参考[Linux nohup 命令](https://www.runoob.com/linux/linux-comm-nohup.html)

语法格式:

``` bash
 nohup Command [ Arg … ] [　& ]
```
例如：

``` bash
nohup java -jar myProject.jar &
```
在终端如果看到以下输出说明运行成功：
``` bash
appending output to nohup.out
```

2. 停止运行

先使用以下命令查找到 nohup 运行脚本到 PID，然后使用 kill 命令来删除

``` bash
ps -aux | grep "myProject.jar"
```
参数说明：

- `a` : 显示所有程序
- `u` : 以用户为主的格式来显示
- `x` : 显示所有程序，不区分终端机

另外也可以使用 `ps -def | grep "myProject.jar"` 命令来查找。

找到 PID 后，就可以使用 kill PID 来删除。
``` bash
kill -9  进程号PID
```

