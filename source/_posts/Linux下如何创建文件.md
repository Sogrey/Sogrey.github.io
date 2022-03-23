---
title: Linux下如何创建文件
author: Sogrey
date: 2020-12-10 15:48:11
tags: [Linux]
categories: Linux
comments: true
toc: true
---

在 Linux 上，包括设备在内的一切皆文件。Linux用户每天都会多次执行创建文件，但在linux上右键菜单中只有创建文件夹（我们也可以使用`mkdir`命令创建），但并没有创建文件的菜单。

<!--more-->

创建文件可以通过以下六个方式来完成。

- `>`：标准重定向符允许我们创建一个 0KB 的空文件。
- `touch`：如果文件不存在的话，`touch` 命令将会创建一个 0KB 的空文件。
- `echo`：通过一个参数显示文本的某行。
- `printf`：用于显示在终端给定的文本。
- `cat`：它串联并打印文件到标准输出。
- `vi`/`vim`：Vim 是一个向上兼容 Vi 的文本编辑器。它常用于编辑各种类型的纯文本。
- `nano`：是一个简小且用户友好的编辑器。它复制了 `pico` 的外观和优点，但它是自由软件。
- `head`：用于打印一个文件开头的一部分。
- `tail`：用于打印一个文件的最后一部分。
- `truncate`：用于缩小或者扩展文件的尺寸到指定大小。



### 使用重定向符（>）创建一个文件

标准重定向符允许我们创建一个 0KB 的空文件。它通常用于重定向一个命令的输出到一个新文件中。在没有命令的情况下使用重定向符号时，它会创建一个文件。

但是它不允许你在创建文件时向其中输入任何文本。然而它对于不是很勤劳的管理员是非常简单有用的。只需要输入重定向符后面跟着你想要的文件名。

``` bahs
$ > demo.txt
```

使用 `ls` 命令查看刚刚创建的文件。

``` bahs
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 0 12月 10 18:33 demo.txt
```

### 使用 touch 命令创建一个文件

`touch` 命令常用于将每个文件的访问和修改时间更新为当前时间。

如果指定的文件名不存在，将会创建一个新的文件。`touch` 不允许我们在创建文件的同时向其中输入一些文本。它默认创建一个 0KB 的空文件。

``` bahs
$ touch demo.txt
```

使用 `ls` 命令查看刚刚创建的文件。

``` bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 0 12月 10 18:33 demo.txt
```

### 在 Linux 上使用 echo 命令创建一个文件

`echo` 内置于大多数的操作系统中。它常用于脚本、批处理文件，以及作为插入文本的单个命令的一部分。

它允许你在创建一个文件时就向其中输入一些文本。当然也允许你在之后向其中输入一些文本。

``` bash
$ echo "Love you." > demo.txt
```

使用 `ls` 命令查看刚刚创建的文件。

``` bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 10 12月 10 18:38 demo.txt
```

可以使用 `cat` 命令查看文件的内容。

``` bash
$ cat demo.txt
Love you.
```

你可以使用两个重定向符 (`>>`) 添加其他内容到同一个文件。

``` bash
$ echo "Love you,too." >> demo.txt
```

你可以使用 `cat` 命令查看添加的内容。

``` bash
$ cat demo.txt
Love you.
Love you,too.
```

### 使用 printf 命令创建一个新的文件

`printf` 命令也可以以类似 `echo` 的方式执行。

`printf` 命令常用来显示在终端窗口给出的字符串。`printf` 可以有格式说明符、转义序列或普通字符。

``` bash
$ printf "Love you.\n" > demo.txt
```

使用 `ls` 命令查看刚刚创建的文件。

``` bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 10 12月 10 18:38 demo.txt
```

使用 `cat` 命令查看文件的内容。

``` bash
$ cat demo.txt
Love you.
```

你可以使用两个重定向符 (`>>`) 添加其他的内容到同一个文件中去。

``` bash
$ printf "Love you,too.\n" >> demo.txt
```

你可以使用 `cat` 命令查看这个文件中添加的内容。

``` bash
$ cat demo.txt
Love you.
Love you,too.

```

### 使用 cat 创建一个文件

`cat` 表示串联concatenate。在 Linux 经常用于读取一个文件中的数据。

`cat` 是在类 Unix 系统中最常使用的命令之一。它提供了三个与文本文件相关的功能：显示一个文件的内容、组合多个文件的内容到一个输出以及创建一个新的文件。（LCTT 译注：如果 `cat` 命令后如果不带任何文件的话，下面的命令在回车后也不会立刻结束，回车后的操作可以按 `Ctrl-C` 或 `Ctrl-D` 来结束。）

```bash
$ cat > demo.txt
Love you.
Love you,too.
^C # Ctrl + C 结束输入
```

使用 `ls` 命令查看创建的文件。

```bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 24 12月 10 21:28 demo.txt
```

使用 `cat` 命令查看文件的内容。

```bash
$ cat demo.txt
Love you.
Love you,too.
```

如果你想向同一个文件中添加其他内容，使用两个连接的重定向符（`>>`）。

```bash
$ cat >> demo.txt
Love you,everyday.
```

你可以使用 `cat` 命令查看添加的内容。

```bash
$ cat demo.txt
Love you.
Love you,too.
Love you,everyday.
```

### 使用 vi/vim 命令创建一个文件

`vim` 是一个向上兼容 `vi` 的文本编辑器。它通常用来编辑所有种类的纯文本。在编辑程序时特别有用。

`vim` 中有很多功能可以用于编辑单个文件。

```bash
$ vi demo.txt
Love you.
Love you,too.
~
~
~
```

按`Esc`输入`:wq`保存退出。

使用 `ls` 查看刚才创建的文件。

```bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 25 12月 10 21:36 demo.txt
```

使用 `cat` 命令查看文件的内容。

```bash
$ cat demo.txt
Love you.
Love you,too.
```

### 使用 nano 命令创建一个文件

`nano` 是一个编辑器，它是一个自由版本的 `pico` 克隆。`nano` 是一个小且用户友好的编辑器。它复制了 `pico` 的外观及优点，并且是一个自由软件，它添加了 `pico` 缺乏的一系列特性，像是打开多个文件、逐行滚动、撤销/重做、语法高亮、行号等等。

光标只能使用键盘方向键控制移动，快捷键使用`Ctrl`+菜单字母标识。

```bash
$ nano demo.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```

![nano创建文件](https://gitee.com/Sogrey/gitee-cdn/raw/master/imgs/nano创建文件.png)

按`Ctrl+X`离开，`Ctrl+Y`选择保存，确定文件名回车即可，使用 `ls` 命令查看创建的文件。

```bash
$ ls -lh demo.java
-rw-rw-r--. 1 sogrey sogrey 121 12月 10 21:50 demo.java
```

使用 `cat` 命令来查看一个文件的内容。

```bash
$ cat demo.java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```

### 使用 head 命令创建一个文件

[`head`](https://www.runoob.com/linux/linux-comm-head.html) 命令通常用于输出一个文件开头的一部分。它默认会打印一个文件的开头 10 行到标准输出。如果有多个文件，则每个文件前都会有一个标题，用来表示文件名。

如下，创建一个0kb空文件。

```bash
$ head -c 0K > demo.txt
```

使用 `ls` 命令查看创建的文件。

```bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 0 12月 10 21:58 demo.txt
```

### 使用 tail 创建一个文件

`tail` 命令通常用来输出一个文件最后的一部分。它默认会打印每个文件的最后 10 行到标准输出。如果有多个文件，则每个文件前都会有一个标题，用来表示文件名。

```bash
$ tail -c 0K > demo.txt
```

使用 `ls` 命令查看创建的文件。

```bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 0 12月 10 21:59 demo.txt
```

### 使用 truncate 命令创建一个文件

`truncate` 命令通常用作将一个文件的尺寸缩小或者扩展为某个指定的尺寸。

```bash
$ truncate -s 0K demo.txt
```

使用 `ls` 命令检查创建的文件。

```bash
$ ls -lh demo.txt
-rw-rw-r--. 1 sogrey sogrey 0 12月 10 21:59 demo.txt
```

------

当作笔记，做个记录。



## 参考


- [在 Linux 上创建文件的 10 个方法](https://linux.cn/article-10549-1.html)
- [在Linux上创建一个特定大小的文件](https://www.2daygeek.com/create-a-file-in-specific-certain-size-linux/)

