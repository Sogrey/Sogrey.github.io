---
title: java调用shell脚本
date: 2020-12-28 17:12:48
categories: Java
author: Sogrey
tags: [Java,shell]
comments: true
toc: true
---


需要bash环境下执行，Windows推荐安装Git For Windows（[国内下载站](https://github.com/waylau/git-for-win)），Linux下默认就是bash。

``` java
String systemType = "linux";//区分Linux和Windows
String tifShPath = "F:/test.sh";// shell脚本
String cmd = "";
if (systemType.equalsIgnoreCase("linux")) {
	try {
		Runtime.getRuntime().exec("chmod 755 -R " + tifShPath);//获取可读可执行权限
	} catch (IOException e) {
		e.printStackTrace();
	}
	cmd = tifShPath;
} else {// windows
	cmd = "bash " + tifShPath;
}
try {
	Process child = Runtime.getRuntime().exec(cmd);
	InputStream in = child.getInputStream();
	BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(in));
	String line;
	while ((line = bufferedReader.readLine()) != null) {
		System.out.println(line);
	}
	in.close();
	child.waitFor();
	if (bufferedReader != null) {
		bufferedReader.close();
	}
} catch (Exception e) {
	System.out.println(e);
}
```

<!--more-->

## 参考

- [java调用shell脚本及注意事项](https://blog.csdn.net/sayoko06/article/details/88797838)
- [java调用shell文件、远程调用shell文件并且传入参数、.sh文件执行的几种方法](https://blog.csdn.net/qq_39477018/article/details/88849003)
- [java调用shell脚本并传递参数](https://blog.csdn.net/dream_broken/article/details/54289008)
- [【大数据】Shell任务在Java中的执行](https://www.yuque.com/docs/share/86e3fa77-39f5-4362-b809-a3c161370bcc)
- [使用ProcessBuilder执行命令行操作](https://www.jianshu.com/p/10f4771909f9)