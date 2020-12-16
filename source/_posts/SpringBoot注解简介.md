---
title: SpringBoot注解简介
date: 2020-12-15 12:07:03
tags: [Java,Spring boot]
categories: Java
comments: true
toc: true
---
使用注解的优势：

1. 采用纯java代码，不在需要配置繁杂的xml文件
2. 在配置中也可享受面向对象带来的好处
3. 类型安全对重构可以提供良好的支持
4. 减少复杂配置文件的同时亦能享受到springIoC容器提供的功能

<!--more-->
## 一、注解(annotations)列表

1、@SpringBootApplication

包含了`@ComponentScan`、`@Configuration`和`@EnableAutoConfiguration`注解。
其中`@ComponentScan`让`Spring Boot`扫描到`Configuration`类并把它加入到程序上下文。

2、@ComponentScan

组件扫描，可自动发现和装配一些`Bean`。

3、@Configuration

等同于`Spring`的`XML`配置文件；使用`Java`代码可以检查类型安全。

4、@EnableAutoConfiguration

自动配置

5、@RestController

该注解是`@Controller`和`@ResponseBody`的合集,表示这是个控制器`Bean`,并且是将函数的返回值直接填入`HTTP`响应体中,是`REST`风格的控制器。

6、@Autowired

自动导入。

7、@PathVariable

获取参数。

8、@JsonBackReference

解决嵌套外链问题。

9、@RepositoryRestResourcepublic

配合spring-boot-starter-data-rest使用。

## 二、注解(annotations)详解

1、`@SpringBootApplication`：申明让`Spring Boot`自动给程序进行必要的配置，这个配置等同于：`@Configuration` ，`@EnableAutoConfiguration` 和 `@ComponentScan` 三个配置。

```
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication // same as @Configuration @EnableAutoConfiguration @ComponentScan
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

2、`@ResponseBody`：表示该方法的返回结果直接写入`HTTP Response Body`中，一般在异步获取数据时使用，用于构建`RESTful`的`api`。

在使用`@RequestMapping`后，返回值通常解析为跳转路径，加上`@ResponseBody`后返回结果不会被解析为跳转路径，而是直接写入`HTTP Response Body`中。

比如异步获取`json`数据，加上`@ResponseBody`后，会直接返回`json`数据。

该注解一般会配合`@RequestMapping`一起使用。

示例代码：

```
@RequestMapping(“/test”)
@ResponseBody
public String test(){
    return ”ok”;
}
```

3、`@Controller`：用于定义控制器类，在`spring` 项目中由控制器负责将用户发来的`URL`请求转发到对应的服务接口（`service`层）

一般这个注解在类中，通常方法需要配合注解`@RequestMapping`。

示例代码：

```
@Controller
@RequestMapping(“/demoInfo”)
publicclass DemoController {
    @Autowired
    private DemoInfoService demoInfoService;

    @RequestMapping("/hello")
    public String hello(Map map){
        System.out.println("DemoController.hello()");
        map.put("hello","from TemplateController.helloHtml");
        // 会使用hello.html或者hello.ftl模板进行渲染显示.
        return"/hello";
    }
}
```

4、`@RestController`：用于标注控制层组件(如`struts`中的`action`)，`@ResponseBody`和`@Controller`的合集。

示例代码：

```
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(“/demoInfo2”)
publicclass DemoController2 {

    @RequestMapping("/test")
    public String test(){
        return"ok";
    }
}
```

5、`@RequestMapping`：提供路由信息，负责`URL`到`Controller`中的具体函数的映射。

6、`@EnableAutoConfiguration`：`Spring Boot`自动配置（`auto-configuration`）：尝试根据你添加的`jar`依赖自动配置你的`Spring`应用。

例如，如果你的`classpath`下存在HSQLDB，并且你没有手动配置任何数据库连接`beans`，那么我们将自动配置一个内存型（`in-memory`）数据库”。

你可以将`@EnableAutoConfiguration`或者`@SpringBootApplication`注解添加到一个`@Configuration`类上来选择自动配置。

如果发现应用了你不想要的特定自动配置类，你可以使用`@EnableAutoConfiguration`注解的排除属性来禁用它们。

搜索Java知音公众号，回复“后端面试”，送你一份Java面试题宝典.pdf

7、`@ComponentScan`：表示将该类自动发现扫描组件。

个人理解相当于，如果扫描到有`@Component`、`@Controller`、`@Service`等这些注解的类，并注册为`Bean`，可以自动收集所有的`Spring`组件，包括`@Configuration`类。

我们经常使用`@ComponentScan`注解搜索`beans`，并结合`@Autowired`注解导入。可以自动收集所有的`Spring`组件，包括`@Configuration`类。

如果没有配置的话，`Spring Boot`会扫描启动类所在包下以及子包下的使用了`@Service`、`@Repository`等注解的类。

8、`@Configuration`：相当于传统的`xml`配置文件，如果有些第三方库需要用到`xml`文件，建议仍然通过`@Configuration`类作为项目的配置主类——可以使用`@ImportResource`注解加载`xml`配置文件。

9、`@Import`：用来导入其他配置类。

10、`@ImportResource`：用来加载`xml`配置文件。

11、`@Autowired`：自动导入依赖的`bean`

12、`@Service`：一般用于修饰`service`层的组件

13、`@Repository`：使用`@Repository`注解可以确保`DAO`或者`repositories`提供异常转译，这个注解修饰的`DAO`或者`repositories`类会被`ComponetScan`发现并配置，同时也不需要为它们提供`XML`配置项。

14、`@Bean`：用`@Bean`标注方法等价于`XML`中配置的`bean`。

15、`@Value`：注入`Spring boot` `application.properties`配置的属性的值。示例代码：

```
@Value(value = “#{message}”)
private String message;
```

16、`@Inject`：等价于默认的`@Autowired`，只是没有`required`属性；

17、`@Component`：泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注。

18、`@Bean`：相当于`XML`中的,放在方法的上面，而不是类，意思是产生一个`bean`,并交给`spring`管理。

19、`@AutoWired`：自动导入依赖的`bean`。`byType`方式。把配置好的`Bean`拿来用，完成属性、方法的组装，它可以对类成员变量、方法及构造函数进行标注，完成自动装配的工作。当加上（`required=false`）时，就算找不到`bean`也不报错。

20、`@Qualifier`：当有多个同一类型的`Bean`时，可以用`@Qualifier(“name”)`来指定。与`@Autowired`配合使用。`@Qualifier`限定描述符除了能根据名字进行注入，但能进行更细粒度的控制如何选择候选者，具体使用方式如下：

```
@Autowired
@Qualifier(value = “demoInfoService”)
private DemoInfoService demoInfoService;
```

21、`@Resource(name=”name”,type=”type”)`：没有括号内内容的话，默认`byName`。与`@Autowired`干类似的事。



## 三、JPA注解

1、`@Entity`：`@Table(name=”“)`：表明这是一个实体类。一般用于`jpa`这两个注解一般一块使用，但是如果表名和实体类名相同的话，`@Table`可以省略。

2、`@MappedSuperClass`:用在确定是父类的`entity`上。父类的属性子类可以继承。

3、`@NoRepositoryBean`:一般用作父类的`repository`，有这个注解，`Spring`不会去实例化该`repository`。

4、`@Column`：如果字段名与列名相同，则可以省略。

5、`@Id`：表示该属性为主键。

6、`@GeneratedValue(strategy=GenerationType.SEQUENCE,generator= “repair_seq”)`：表示主键生成策略是`sequence`（可以为`Auto`、`IDENTITY`、`native`等，`Auto`表示可在多个数据库间切换），指定`sequence`的名字是`repair_seq`。

7、`@SequenceGeneretor(name = “repair_seq”, sequenceName = “seq_repair”, allocationSize = 1)`：`name`为`sequence`的名称，以便使用，`sequenceName`为数据库的`sequence`名称，两个名称可以一致。

8、`@Transient`：表示该属性并非一个到数据库表的字段的映射,`ORM`框架将忽略该属性。

如果一个属性并非数据库表的字段映射,就务必将其标示为`@Transient`,否则,`ORM`框架默认其注解为`@Basic`。

9、`@Basic(fetch=FetchType.LAZY)`：标记可以指定实体属性的加载方式。

10、`@JsonIgnore`：作用是`json`序列化时将`Java bean`中的一些属性忽略掉,序列化和反序列化都受影响。

11、`@JoinColumn（name=”loginId”）`:一对一：本表中指向另一个表的外键。一对多：另一个表指向本表的外键。

12、`@OneToOne、@OneToMany、@ManyToOne`：对应`hibernate`配置文件中的一对一，一对多，多对一。

## 四、SpringMVC相关注解

1、`@RequestMapping`：`@RequestMapping(“/path”)`表示该控制器处理所有“/path”的UR L请求。

`RequestMapping`是一个用来处理请求地址映射的注解，可用于类或方法上。

用于类上，表示类中的所有响应请求的方法都是以该地址作为父路径。该注解有六个属性：

- `params`:指定`request`中必须包含某些参数值是，才让该方法处理。
- `headers`:指定`request`中必须包含某些指定的`header`值，才能让该方法处理请求。
- `value`:指定请求的实际地址，指定的地址可以是`URI Template` 模式
- `method`:指定请求的method类型， `GET、POST、PUT、DELETE`等
- `consumes`:指定处理请求的提交内容类型（`Content-Type`），如`application/json,text/html`;
- `produces`:指定返回的内容类型，仅当`request`请求头中的(`Accept`)类型中包含该指定类型才返回。

2、`@RequestParam`：用在方法的参数前面。

3、`@PathVariable`:路径变量。如：

```
RequestMapping(“user/get/{macAddress}”)
public String getByMacAddress(@PathVariable String macAddress){
    //do something;
}
```

参数与大括号里的名字一样要相同。

## 五、全局异常处理

`@ControllerAdvice`：包含`@Component`。可以被扫描到。统一处理异常。

`@ExceptionHandler（Exception.class）`：用在方法上面表示遇到这个异常就执行以下方法。