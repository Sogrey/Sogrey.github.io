---
title: Mysql踩坑记
date: 2021-04-10 23:49:48
tags: [Mysql,踩坑记]
categories: Mysql
comments: true
toc: true
---

记录MySQL开发中遇到的填坑经历。

<!--more-->

## 局域网访问报错 message from server: "Host 'xxx' is not allowed to connect to this MySQL server

- **改表法 (亲测)**

可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%" 
``` cmd
D:\Programs\mysql-8.0.23-winx64\bin>mysql -u root -p 
Enter password: *******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 33
Server version: 8.0.23 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use mysql;
Database changed
mysql> select host, user from user;
+-----------+------------------+
| host      | user             |
+-----------+------------------+
| localhost | mysql.infoschema |
| localhost | mysql.session    |
| localhost | mysql.sys        |
| localhost | root             |
+-----------+------------------+
4 rows in set (0.00 sec)

mysql> update user set host = '%' where user = 'root';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select host, user from user;
+-----------+------------------+
| host      | user             |
+-----------+------------------+
| %         | root             |
| localhost | mysql.infoschema |
| localhost | mysql.session    |
| localhost | mysql.sys        |
+-----------+------------------+
4 rows in set (0.00 sec)

mysql>
```

- **授权法**

例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。 
``` cmd
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 
 
FLUSH   PRIVILEGES; 
```
如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器，并使用mypassword作为密码 
``` cmd
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;   www.2cto.com  
 
FLUSH   PRIVILEGES; 
```
如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器的dk数据库，并使用mypassword作为密码 
``` cmd
GRANT ALL PRIVILEGES ON dk.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION; 
 
FLUSH   PRIVILEGES; 
```

- **另外一种方法**

在安装mysql的机器上运行：   

1. `d:\mysql\bin\>mysql   -h   localhost   -u   root`这样应该可以进入MySQL服务器
2. `mysql>GRANT   ALL   PRIVILEGES   ON   *.*   TO   'root'@'%'   WITH   GRANT   OPTION` 赋予任何主机访问数据的权限 
3. `mysql>FLUSH   PRIVILEGES`修改生效 
4. `mysql>EXIT` 退出MySQL服务器 

这样就可以在其它任何的主机上以root身份登录啦！ 