---
title: Mysql踩坑记
author: Sogrey
date: 2021-04-10 23:49:48
tags: [Mysql,踩坑记]
categories: Mysql
comments: true
toc: true
---

记录MySQL开发中遇到的填坑经历。

<!--more-->

## 1.局域网访问报错 message from server: "Host 'xxx' is not allowed to connect to this MySQL server

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

## 2. 链接MySQL提示“Too many connections”

字面意思就是连接数过多，超限了。那么现在就查下当前限制多少连接数，并且修改最大连接数。

```cmd
Microsoft Windows [版本 10.0.19043.1348]
(c) Microsoft Corporation。保留所有权利。

D:\Programs\mysql-8.0.23-winx64>cd bin

D:\Programs\mysql-8.0.23-winx64\bin>mysql -u root -p # 使用root用户登录mysql
Enter password: *******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 8
Server version: 8.0.23 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show processlist; # 查询mysql的所有连接
+----+-----------------+-----------------+------+---------+------+------------------------+------------------+
| Id | User            | Host            | db   | Command | Time | State                  | Info             |
+----+-----------------+-----------------+------+---------+------+------------------------+------------------+
|  5 | event_scheduler | localhost       | NULL | Daemon  | 4304 | Waiting on empty queue | NULL             |
|  8 | root            | localhost:55747 | NULL | Query   |    0 | init                   | show processlist |
+----+-----------------+-----------------+------+---------+------+------------------------+------------------+
2 rows in set (0.00 sec)

mysql> show variables like '%max_connections%'; # 查询最大连接数，看到只有 20
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| max_connections        | 20    |
| mysqlx_max_connections | 100   |
+------------------------+-------+
2 rows in set, 1 warning (0.01 sec)

mysql> set GLOBAL max_connections=1000; # 设置最大连接数 1000
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like '%max_connections%'; # 再次查询最大连接数，看到已经是设置好的 1000 了
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| max_connections        | 1000  |
| mysqlx_max_connections | 100   |
+------------------------+-------+
2 rows in set, 1 warning (0.00 sec)

mysql> exit # 退出mysql命令行
Bye

D:\Programs\mysql-8.0.23-winx64\bin>
```

## 3. Loading class `com.mysql.jdbc.Driver`. This is deprecated. The new driver class is `com.mysql.cj.jdbc.Driver`. The driver is automatically registered via the SPI and manual loading of the driver class is generally unnecessary.

因为连接mysql8版本的数据库需要新的驱动。

``` bash
# spring.datasource.driver-class-name=com.mysql.jdbc.Driver
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

## 4. MySQL Workbench 连接不上mysql问题

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/MySQL%20Workbench%20%E8%BF%9E%E6%8E%A5%E4%B8%8D%E4%B8%8Amysql%E9%97%AE%E9%A2%98-1.png)

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/MySQL%20Workbench%20%E8%BF%9E%E6%8E%A5%E4%B8%8D%E4%B8%8Amysql%E9%97%AE%E9%A2%98-2.png)

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/MySQL%20Workbench%20%E8%BF%9E%E6%8E%A5%E4%B8%8D%E4%B8%8Amysql%E9%97%AE%E9%A2%98-3.png)

加入host的范围

``` sql
mysql> update user set host = '%' where user = 'root';

mysql> select user,host from mysql.user;
+------------------+-----------+
| user             | host      |
+------------------+-----------+
| root             | %         |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
+------------------+-----------+
4 rows in set (0.00 sec)

mysql>  flush privileges;
Query OK, 0 rows affected (0.01 sec)
```

终于成功。记得权限类的要`flush privileges`!

![](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/MySQL%20Workbench%20%E8%BF%9E%E6%8E%A5%E4%B8%8D%E4%B8%8Amysql%E9%97%AE%E9%A2%98-4.png)