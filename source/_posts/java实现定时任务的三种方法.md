---
title: java实现定时任务的三种方法(收集)
date: 2018-01-03 14:08:44
categories: Java
tags: [Java]
---

* 普通thread 

这是最常见的，创建一个thread，然后让它在while循环里一直运行着，通过sleep方法来达到定时任务的效果。这样可以快速简单的实现，代码如下： 

``` java
package org.sogrey.task;

public class TaskRunnable {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
        // run in a second  
        final long timeInterval = 1000;  
        Runnable runnable = new Runnable() {  
            public void run() {  
                while (true) {  
                    // ------- code for task to run  
                    System.out.println("Hello !!");  
                    // ------- ends here  
                    try {  
                        Thread.sleep(timeInterval);  
                    } catch (InterruptedException e) {  
                        e.printStackTrace();  
                    }  
                }  
            }  
        };  
        Thread thread = new Thread(runnable);  
        thread.start();  
	}
}

```
<!-- more -->

* TimerTask 

  
 于第一种方式相比，优势 1>当启动和去取消任务时可以控制 2>第一次执行任务时可以指定你想要的delay时间  在实现时，Timer类可以调度任务，imerTask则是通过在run()方法里实现具体任务。 Timer实例可以调度多任务，它是线程安全的。

 当Timer的构造器被调用时，它创建了一个线程，这个线程可以用来调度任务。

``` java
package org.sogrey.task;

import java.util.Timer;
import java.util.TimerTask;

public class TaskTimerTask {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		TimerTask task = new TimerTask() {  
            @Override  
            public void run() {  
                // task to run goes here  
                System.out.println("Hello !!!");  
            }  
        };  
        Timer timer = new Timer();  
        long delay = 0;  
        long intevalPeriod = 1 * 1000;  
        // schedules the task to be run in an interval  
        timer.scheduleAtFixedRate(task, delay, intevalPeriod);  
	}
}
```

* ScheduledExecutorService

ScheduledExecutorService是从Java SE5的java.util.concurrent里，做为并发工具类被引进的，这是最理想的定时任务实现方式。  

相比于上两个方法，它有以下好处：
 
 - 1>相比于Timer的单线程，它是通过线程池的方式来执行任务的  
 - 2>可以很灵活的去设定第一次执行任务delay时间 
 - 3>提供了良好的约定，以便设定执行的时间间隔 

下面是实现代码，我们通过ScheduledExecutorService#scheduleAtFixedRate展示这个例子，通过代码里参数的控制，首次执行加了delay时间。

``` java
package org.sogrey.task;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class TaskScheduledExecutorService {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Runnable runnable = new Runnable() {  
            public void run() {  
                // task to run goes here  
                System.out.println("Hello !!");  
            }  
        };  
        ScheduledExecutorService service = Executors  
                .newSingleThreadScheduledExecutor();  
        // 第二个参数为首次执行的延时时间，第三个参数为定时执行的间隔时间  
        service.scheduleAtFixedRate(runnable, 10, 1, TimeUnit.SECONDS);  
	}
}
```

转自：[java实现定时任务的三种方法](http://blog.csdn.net/haorengoodman/article/details/23281343/)