---
title: SpringBoot实现定时任务
date: 2020-12-15 12:07:28
tags: [Java,Spring boot,Scheduled]
categories: Java
comments: true
toc: true
---

Spring 3.0 版本之后自带定时任务，提供了@EnableScheduling注解和@Scheduled注解来实现定时任务功能。

使用SpringBoot创建定时任务非常简单，目前主要有以下三种创建方式：

1. 基于注解（@Scheduled）
2. 基于接口（SchedulingConfigurer） 前者相信大家都很熟悉，但是实际使用中我们往往想从数据库中读取指定时间来动态执行定时任务，这时候基于接口的定时任务就派上用场了。
3. 基于注解设定多线程定时任务

<!--more-->

## 基于注解（@Scheduled）

### @Scheduled注解和@EnableScheduling注解的使用
基于注解@Scheduled默认为单线程，开启多个任务时，任务的执行时机会受上一个任务执行时间的影响。

- `@EnableScheduling`注解： 在配置类上使用，开启计划任务的支持（类上）。
- `@Scheduled`注解： 来声明这是一个任务，包括 `cron`，`fixDelay`，`fixRate` 等类型（方法上，需先开启计划任务的支持）。

``` java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling // 开启定时任务
/**
 * 程序主入口
 */
public class App {
	public static void main(String[] args) {
		SpringApplication.run(App.class, args);
	}
}
```

一个简单的定时任务，每5秒执行一次：
``` java
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduleTask {
	@Scheduled(cron="0/5 * *  * * ? ")   //每5秒执行一次
    public void execute(){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //设置日期格式
        System.out.println("定时任务，当前时刻： " + df.format(new Date()));
    }
}
```
启动执行如下：
```
定时任务，当前时刻： 2020-12-23 23:37:30
定时任务，当前时刻： 2020-12-23 23:37:35
定时任务，当前时刻： 2020-12-23 23:37:40
定时任务，当前时刻： 2020-12-23 23:37:45
定时任务，当前时刻： 2020-12-23 23:37:50
定时任务，当前时刻： 2020-12-23 23:37:55
定时任务，当前时刻： 2020-12-23 23:38:00
```

### `@Scheduled`注解参数

先来看下 Scheduled 源码：

``` java
/*
 * Copyright 2002-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.springframework.scheduling.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Repeatable;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * An annotation that marks a method to be scheduled. Exactly one of
 * the {@link #cron()}, {@link #fixedDelay()}, or {@link #fixedRate()}
 * attributes must be specified.
 *
 * <p>The annotated method must expect no arguments. It will typically have
 * a {@code void} return type; if not, the returned value will be ignored
 * when called through the scheduler.
 *
 * <p>Processing of {@code @Scheduled} annotations is performed by
 * registering a {@link ScheduledAnnotationBeanPostProcessor}. This can be
 * done manually or, more conveniently, through the {@code <task:annotation-driven/>}
 * element or @{@link EnableScheduling} annotation.
 *
 * <p>This annotation may be used as a <em>meta-annotation</em> to create custom
 * <em>composed annotations</em> with attribute overrides.
 *
 * @author Mark Fisher
 * @author Juergen Hoeller
 * @author Dave Syer
 * @author Chris Beams
 * @since 3.0
 * @see EnableScheduling
 * @see ScheduledAnnotationBeanPostProcessor
 * @see Schedules
 */
@Target({ElementType.METHOD, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Repeatable(Schedules.class)
public @interface Scheduled {

	/**
	 * A special cron expression value that indicates a disabled trigger: {@value}.
	 * <p>This is primarily meant for use with ${...} placeholders, allowing for
	 * external disabling of corresponding scheduled methods.
	 * @since 5.1
	 */
	String CRON_DISABLED = "-";


	/**
	 * A cron-like expression, extending the usual UN*X definition to include triggers
	 * on the second as well as minute, hour, day of month, month and day of week.
	 * <p>E.g. {@code "0 * * * * MON-FRI"} means once per minute on weekdays
	 * (at the top of the minute - the 0th second).
	 * <p>The special value {@link #CRON_DISABLED "-"} indicates a disabled cron trigger,
	 * primarily meant for externally specified values resolved by a ${...} placeholder.
	 * @return an expression that can be parsed to a cron schedule
	 * @see org.springframework.scheduling.support.CronSequenceGenerator
	 */
	String cron() default "";

	/**
	 * A time zone for which the cron expression will be resolved. By default, this
	 * attribute is the empty String (i.e. the server's local time zone will be used).
	 * @return a zone id accepted by {@link java.util.TimeZone#getTimeZone(String)},
	 * or an empty String to indicate the server's default time zone
	 * @since 4.0
	 * @see org.springframework.scheduling.support.CronTrigger#CronTrigger(String, java.util.TimeZone)
	 * @see java.util.TimeZone
	 */
	String zone() default "";

	/**
	 * Execute the annotated method with a fixed period in milliseconds between the
	 * end of the last invocation and the start of the next.
	 * @return the delay in milliseconds
	 */
	long fixedDelay() default -1;

	/**
	 * Execute the annotated method with a fixed period in milliseconds between the
	 * end of the last invocation and the start of the next.
	 * @return the delay in milliseconds as a String value, e.g. a placeholder
	 * or a {@link java.time.Duration#parse java.time.Duration} compliant value
	 * @since 3.2.2
	 */
	String fixedDelayString() default "";

	/**
	 * Execute the annotated method with a fixed period in milliseconds between
	 * invocations.
	 * @return the period in milliseconds
	 */
	long fixedRate() default -1;

	/**
	 * Execute the annotated method with a fixed period in milliseconds between
	 * invocations.
	 * @return the period in milliseconds as a String value, e.g. a placeholder
	 * or a {@link java.time.Duration#parse java.time.Duration} compliant value
	 * @since 3.2.2
	 */
	String fixedRateString() default "";

	/**
	 * Number of milliseconds to delay before the first execution of a
	 * {@link #fixedRate()} or {@link #fixedDelay()} task.
	 * @return the initial delay in milliseconds
	 * @since 3.2
	 */
	long initialDelay() default -1;

	/**
	 * Number of milliseconds to delay before the first execution of a
	 * {@link #fixedRate()} or {@link #fixedDelay()} task.
	 * @return the initial delay in milliseconds as a String value, e.g. a placeholder
	 * or a {@link java.time.Duration#parse java.time.Duration} compliant value
	 * @since 3.2.2
	 */
	String initialDelayString() default "";

}
```

#### `cron` 参数接收一个cron表达式，cron表达式是一个字符串，字符串以5或6个空格隔开，分开共6或7个域，每一个域代表一个含义。

cron 表达式语法：

格式：**[秒] [分] [小时] [日] [月] [周] [年]**

| 序号 | 说明 | 是否必填 | 允许填写的值       | 允许的通配符  |
| :--- | :--- | :------- | :----------------- | :------------ |
| 1    | 秒   | 是       | 0-59               | , - * /       |
| 2    | 分   | 是       | 0-59               | , - * /       |
| 3    | 小时 | 是       | 0-23               | , - * /       |
| 4    | 日   | 是       | 1-31               | , - * ? / L W |
| 5    | 月   | 是       | 1-12 or JAN-DEC    | , - * /       |
| 6    | 周   | 是       | 1-7 or SUN-SAT     | , - * ? / L # |
| 7    | 年   | 否       | empty 或 1970-2099 | , - * /       |

特殊字符说明：

- **秒**  允许值范围: 0~59 ,不允许为空值，若值不合法，调度器将抛出SchedulerException异常
  - `*`  每隔1秒钟触发
  - `,`  在指定的秒数触发，比如"0,15,45"代表0秒、15秒和45秒时触发任务
  - `-`  在指定的范围内触发，比如"25-45"代表从25秒开始触发到45秒结束触发，每隔1秒触发1次
  - `/`  代表触发步进(step)，"/"前面的值代表初始值("*"等同"0")，后面的值代表偏移量，比如"0/20"或者"*/20"代表从0秒钟开始，每隔20秒钟触发1次，即0秒触发1次，20秒触发1次，40秒触发1次；"5/20"代表5秒触发1次，25秒触发1次，45秒触发1次；"10-45/20"代表在[10,45]内步进20秒命中的时间点触发，即10秒触发1次，30秒触发1次
- **分钟**  允许值范围: 0~59 ,不允许为空值，若值不合法，调度器将抛出SchedulerException异常
  - `*`  代表每隔1分钟触发
  - `,`  代表在指定的分钟触发，比如"10,20,40"代表10分钟、20分钟和40分钟时触发任务
  - `-`  代表在指定的范围内触发，比如"5-30"代表从5分钟开始触发到30分钟结束触 发，每隔1分钟触发
  - `/`  代表触发步进(step)，"/"前面的值代表初始值("*"等同"0")，后面的值代表偏移量，比如"0/25"或者"*/25"代表从0分钟开始，每隔25分钟触发1次，即0分钟触发1次，第25分钟触发1次，第50分钟触发1次；"5/25"代表5分钟触发1次，30分钟触发1次，55分钟触发1次；"10-45/20"代表在[10,45]内步进20分钟命中的时间点触发，即10分钟触发1次，30分钟触发1次
- **小时**  允许值范围: 0~23 ,不允许为空值，若值不合法，调度器将抛出SchedulerException异常
  - `*`  代表每隔1小时触发
  - `,`  代表在指定的时间点触发，比如"10,20,23"代表10点钟、20点钟和23点触发任务
  - `-`  代表在指定的时间段内触发，比如"20-23"代表从20点开始触发到23点结束触发，每隔1小时触发
  - `/`  代表触发步进(step)，"/"前面的值代表初始值("*"等同"0")，后面的值代表偏移量，比如"0/1"或者"*/1"代表从0点开始触发，每隔1小时触发1次；"1/2"代表从1点开始触发，以后每隔2小时触发一次
- **日期**  允许值范围: 1~12 (JAN-DEC),不允许为空值，若值不合法，调度器将抛出SchedulerException异常
  - `*`  代表每个月都触发
  - `,`  代表在指定的月份触发，比如"1,6,12"代表1月份、6月份和12月份触发任务
  - `-`  代表在指定的月份范围内触发，比如"1-6"代表从1月份开始触发到6月份结束触发，每隔1个月触发
  - `/`  代表触发步进(step)，"/"前面的值代表初始值("*"等同"1")，后面的值代表偏移量，比如"1/2"或者"*/2"代表从1月份开始触发，每隔2个月触发1次；"6/6"代表从6月份开始触发，以后每隔6个月触发一次；"1-6/12"表达式意味着每年1月份触发
- **星期**  允许值范围: 1~7 (SUN-SAT),1代表星期天(一星期的第一天)，以此类推，7代表星期六(一星期的最后一天)，不允许为空值，若值不合法，调度器将抛出SchedulerException异常
  - `*`  代表每星期都触发
  - `,`  代表在指定的星期约定触发，比如"1,3,5"代表星期天、星期二和星期四触发
  - `-`  代表在指定的星期范围内触发，比如"2-4"代表从星期一开始触发到星期三结束触发，每隔1天触发
  - `/`  代表触发步进(step)，"/"前面的值代表初始值("*"等同"1")，后面的值代表偏移量，比如"1/3"或者"*/3"代表从星期天开始触发，每隔3天触发1次；"1-5/2"表达式意味着在[1,5]范围内，每隔2天触发，即星期天、星期二、星期四触发
  - `?`  与{日期}互斥，即意味着若明确指定{日期}触发，则表示{星期}无意义，以免引起冲突和混乱
  - `L`  如果{星期}占位符如果是"L"，即意味着星期的的最后一天触发，即星期六触发，L= 7或者 L = SAT，因此，"5L"意味着一个月的最后一个星期四触发
  - `#`  用来指定具体的周数，"#"前面代表星期，"#"后面代表本月第几周，比如"2#2"表示本月第二周的星期一，"5#3"表示本月第三周的星期四，因此，"5L"这种形式只不过是"#"的特殊形式而已
- **年份**  允许值范围: 1970~2099 ,允许为空，若值不合法，调度器将抛出SchedulerException异常
  - `*`  代表每年都触发
  - `,`  代表在指定的年份才触发，比如"2011,2012,2013"代表2011年、2012年和2013年触发任务
  - `-`  代表在指定的年份范围内触发，比如"2011-2020"代表从2011年开始触发到2020年结束触发，每隔1年触发
  - `/`  代表触发步进(step)，"/"前面的值代表初始值("*"等同"1970")，后面的值代表偏移量，比如"2011/2"或者"*/2"代表从2011年开始触发，每隔2年触发1次 


**注意：除了{日期}和{星期}可以使用"?"来实现互斥，表达无意义的信息之外，其他占位符都要具有具体的时间含义，且依赖关系为：年->月->日期(星期)->小时->分钟->秒数**

- `*`字符被用来指定所有的值。如：`*`在分钟的字段域里表示“每分钟”。
- `?`字符只在日期域和星期域中使用。它被用来指定“非明确的值”。当你需要通过在这两个域中的一个来指定一些东西的时候，它是有用的。看下面的例子你就会明白。 月份中的日期和星期中的日期这两个元素时互斥的一起应该通过设置一个问号来表明不想设置那个字段。
- `-`字符被用来指定一个范围。如：“10-12”在小时域意味着“10点、11点、12点”。
- `,`字符被用来指定另外的值。如：“MON,WED,FRI”在星期域里表示”星期一、星期三、星期五”。
- `/`字符用于指定增量。如：“0/15”在秒域意思是每分钟的0，15，30和45秒。“5/15”在分钟域表示每小时的5，20，35和50。符号“*”在“/”前面（如：*/10）等价于0在“/”前面（如：0/10）。记住一条本质：表达式的每个数值域都是一个有最大值和最小值的集合，如：秒域和分钟域的集合是0-59，日期域是1-31，月份域是1-12。字符“/”可以帮助你在每个字符域中取相应的数值。如：“7/6”在月份域的时候只有当7月的时候才会触发，并不是表示每个6月。
- `L`是‘last’的省略写法可以表示day-of-month和day-of-week域，但在两个字段中的意思不同，例如day-of-month域中表示一个月的最后一天。如果在day-of-week域表示‘7’或者‘SAT’，如果在day-of-week域中前面加上数字，它表示一个月的最后几天，例如‘6L’就表示一个月的最后一个星期五。
- `W`字符只允许日期域出现。这个字符用于指定日期的最近工作日。例如：如果你在日期域中写 “15W”，表示：这个月15号最近的工作日。所以，如果15号是周六，则任务会在14号触发。如果15好是周日，则任务会在周一也就是16号触发。如果是在日期域填写“1W”即使1号是周六，那么任务也只会在下周一，也就是3号触发，“W”字符指定的最近工作日是不能够跨月份的。字符“W”只能配合一个单独的数值使用，不能够是一个数字段，如：1-15W是错误的。

> `L`和`W`可以在日期域中联合使用，LW表示这个月最后一周的工作日。

- `#`字符只允许在星期域中出现。这个字符用于指定本月的某某天。例如：“6#3”表示本月第三周的星期五（6表示星期五，3表示第三周）。“2#1”表示本月第一周的星期一。“4#5”表示第五周的星期三。
- `C`字符允许在日期域和星期域出现。这个字符依靠一个指定的“日历”。也就是说这个表达式的值依赖于相关的“日历”的计算结果，如果没有“日历”关联，则等价于所有包含的“日历”。如：日期域是“5C”表示关联“日历”中第一天，或者这个月开始的第一天的后5天。星期域是“1C”表示关联“日历”中第一天，或者星期的第一天的后1天，也就是周日的后一天（周一）。

**表达式举例**
```
"0 0 12 * * ?" 每天中午12点触发
"0 15 10 ? * *" 每天上午10:15触发
"0 15 10 * * ?" 每天上午10:15触发
"0 15 10 * * ? *" 每天上午10:15触发
"0 15 10 * * ? 2005" 2005年的每天上午10:15触发
"0 * 14 * * ?" 在每天下午2点到下午2:59期间的每1分钟触发
"0 0/5 14 * * ?" 在每天下午2点到下午2:55期间的每5分钟触发
"0 0/5 14,18 * * ?" 在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发
"0 0-5 14 * * ?" 在每天下午2点到下午2:05期间的每1分钟触发
"0 10,44 14 ? 3 WED" 每年三月的星期三的下午2:10和2:44触发
"0 15 10 ? * MON-FRI" 周一至周五的上午10:15触发
"0 15 10 15 * ?" 每月15日上午10:15触发
"0 15 10 L * ?" 每月最后一日的上午10:15触发
"0 15 10 ? * 6L" 每月的最后一个星期五上午10:15触发
"0 15 10 ? * 6L 2002-2005" 2002年至2005年的每月的最后一个星期五上午10:15触
"0 15 10 ? * 6#3" 每月的第三个星期五上午10:15触发
```

在线Cron表达式生成器 : https://cron.qqe2.com/

## 基于接口SchedulingConfigurer

Spring 中，创建定时任务除了使用`@Scheduled` 注解外，还可以使用 `SchedulingConfigurer`。

`@Schedule` 注解有一个缺点，其定时的时间不能动态的改变，而基于 `SchedulingConfigurer` 接口的方式可以做到。`SchedulingConfigurer` 接口可以实现在`@Configuration` 类上，同时不要忘了，还需要`@EnableScheduling` 注解的支持。

该接口的实现方法如下：
``` java
public void configureTasks(ScheduledTaskRegistrar taskRegistrar)
```
方法包含定时任务，延时任务，基于 `Cron` 表达式的任务，以及 `Trigger` 触发的任务。

下面演示了使用方法。
``` java
@Configuration
@ComponentScan(value = "com.learn")
@EnableScheduling
public class Config implements SchedulingConfigurer {
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		taskRegistrar.addFixedRateTask(() -> System.out.println("执行定时任务1: " + new Date()), 1000);
		TriggerTask triggrtTask = new TriggerTask( // 任务内容.拉姆达表达式
				() -> {System.out.println("执行定时任务2: " + new Date());},
				// 设置触发器，这里是一个拉姆达表达式，传入的TriggerContext类型，返回的是Date类型
				triggerContext -> {
					// 2.3 返回执行周期(Date)
					return new CronTrigger("*/2 * * * * ?").nextExecutionTime(triggerContext);
				});
 
		taskRegistrar.addTriggerTask(triggrtTask);
	}
}
```
默认的，`SchedulingConfigurer` 使用的也是单线程的方式，如果需要配置多线程，则需要指定 `PoolSize`，加入如下代码即可：
``` java
@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
		taskScheduler.setPoolSize(10);
		taskScheduler.initialize();
		taskRegistrar.setTaskScheduler(taskScheduler);
	}
```
动态修改定时规则

## 基于注解设定多线程定时任务


## 参考

- [SpringBoot使用@Scheduled注解实现定时任务](https://blog.csdn.net/pan_junbiao/article/details/109399280)
- [Cron表达式的详细用法](https://www.jianshu.com/p/e9ce1a7e1ed1)
