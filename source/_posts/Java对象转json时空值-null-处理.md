---
title: Java对象转json时空值(null)处理
date: 2018-12-20 09:33:23
tags: [Java,Json]
author: Sogrey
categories: Java
comments: true
toc: true
---

> Java对象在转json的时候，如果对象里面有属性值为null的话，那么在json序列化的时候要不要序列出来呢？

<!-- more -->

## 1 fastjson

fastJson在转换java对象为json的时候，默认是不序列化null值对应的key的也就是说当对象里面的属性为空的时候，在转换成json时，不序列化那些为null值的属性

``` java
package top.sogrey.java2Json;

import top.sogrey.java2Json.bean.User;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;

/**
 * fastjson 版本是 1.2.54
 * 
 * @author Administrator
 * 
 */
public class fastjsonDemo {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		User user = new User();
		user.setUserName("Sogrey");
		String str = JSONObject.toJSONString(user);// fastjson默认转换是不序列化null值对应的key的
		System.out.println(str);
		// 输出结果是：{"age":0,"userName":"Sogrey"}
	}
}

```

但是如果想把null对应的key序列化出来呢？ 

``` java
		// 如果需要序列化null对应的key
		str = JSONObject
				.toJSONString(
						user,
						new SerializerFeature[] { SerializerFeature.WriteMapNullValue });
		System.out.println(str);
		// 输出结果是： {"age":0,"job":null,"userName":"Sogrey"}
```

想字符类型字段如果为null,转换输出为”“,而非null ，需要多加一个参数：WriteNullStringAsEmpty

``` java
		// 想字符类型字段如果为null,转换输出为"",而非null ，需要多加一个参数：WriteNullStringAsEmpty
		str = JSONObject.toJSONString(user, new SerializerFeature[] {
				SerializerFeature.WriteMapNullValue,
				SerializerFeature.WriteNullStringAsEmpty });
		System.out.println(str);
		//输出结果是：{"age":0,"job":"","userName":"Sogrey"}
```

## 2  Gson

 gson和fastjson一样，默认是不序列化null值对应的key的

 ``` java
package top.sogrey.java2Json;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import top.sogrey.java2Json.bean.User;

public class GsonDemo {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		User user = new User();
		user.setUserName("Sogrey");
		Gson g = new GsonBuilder().create();
		String str = g.toJson(user);
		System.out.println(str);
		// {"userName":"Sogrey","age":0}
	}
}
 ```

 若是想序列化null值对应的key，只需要将以上创建代码改成以下代码就行：
 ``` java
		g = new GsonBuilder().serializeNulls().create();
		str = g.toJson(user);
		System.out.println(str);
		// {"userName":"Sogrey","age":0,"job":null}
 ```

[github](https://github.com/Sogrey/JavaBean2Json)