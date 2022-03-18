---
title: 使用java8中Stream轻松遍历树形结构
date: 2022-03-18 22:23:55
tags: [JSON,JavaScript]
categories: JavaScript
comments: true
toc: true
---
之前发过一篇[json转树状结构（收集）](https://sogrey.top/article/json%E8%BD%AC%E6%A0%91%E7%8A%B6%E7%BB%93%E6%9E%84%EF%BC%88%E6%94%B6%E9%9B%86%EF%BC%89/)以处理id-pid结构形式json数据转为树形结构，多年来再次看到同样问题却有了新的想法。

<!--more-->

可能平常会遇到一些需求，比如构建菜单，构建树形结构，数据库一般就使用父id来表示，为了降低数据库的查询压力，我们可以使用Java8中的Stream流一次性把数据查出来，然后通过流式处理.

先看实体实现类：

Menu.java
``` java
package top.sogrey.mulMenu;

import java.util.List;

public class Menu {
	/**
	 * id
	 */
	public Integer id;
	/**
	 * 名称
	 */
	public String name;
	/**
	 * 父id ，根节点为0
	 */
	public Integer parentId;
	/**
	 * 子节点信息
	 */
	public List<Menu> childList;

	public Menu(Integer id, String name, Integer parentId) {
		this.id = id;
		this.name = name;
		this.parentId = parentId;
	}

	public Menu(Integer id, String name, Integer parentId, List<Menu> childList) {
		this.id = id;
		this.name = name;
		this.parentId = parentId;
		this.childList = childList;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public List<Menu> getChildList() {
		return childList;
	}

	public void setChildList(List<Menu> childList) {
		this.childList = childList;
	}
}
```
java 8 中的 Stream 递归组装树形结构：
``` java
package top.sogrey.mulMenu;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import com.alibaba.fastjson.JSON;

public class MulMenu {

	public static void main(String[] args) {
		testtree();
	}

	public static void testtree() {
		// 模拟从数据库查询出来
		List<Menu> menus = Arrays.asList(
            new Menu(1, "根节点", 0), new Menu(2, "子节点1", 1), new Menu(3, "子节点1.1", 2),
			new Menu(4, "子节点1.2", 2), new Menu(5, "根节点1.3", 2), new Menu(6, "根节点2", 1),
            new Menu(7, "根节点2.1", 6),new Menu(8, "根节点2.2", 6), new Menu(9, "根节点2.2.1", 7),
            new Menu(10, "根节点2.2.2", 7), new Menu(11, "根节点3", 1), new Menu(12, "根节点3.1", 11));

		// 获取父节点
		List<Menu> collect = menus.stream().filter(m -> m.getParentId() == 0).map((m) -> {
			m.setChildList(getChildrens(m, menus));
			return m;
		}).collect(Collectors.toList());
		System.out.println(JSON.toJSON(collect));
	}

	/**
	 * 递归查询子节点
	 * 
	 * @param root 根节点
	 * @param all  所有节点
	 * @return 根节点信息
	 */
	private static List<Menu> getChildrens(Menu root, List<Menu> all) {
		List<Menu> children = all.stream().filter(m -> {
			return Objects.equals(m.getParentId(), root.getId());
		}).map((m) -> {
			m.setChildList(getChildrens(m, all));
			return m;
		}).collect(Collectors.toList());
		return children;
	}
}
```

输出结构如下：

``` json
[
    {
        "name": "根节点", 
        "childList": [
            {
                "name": "子节点1", 
                "childList": [
                    {
                        "name": "子节点1.1", 
                        "childList": [ ], 
                        "id": 3, 
                        "parentId": 2
                    }, 
                    {
                        "name": "子节点1.2", 
                        "childList": [ ], 
                        "id": 4, 
                        "parentId": 2
                    }, 
                    {
                        "name": "根节点1.3", 
                        "childList": [ ], 
                        "id": 5, 
                        "parentId": 2
                    }
                ], 
                "id": 2, 
                "parentId": 1
            }, 
            {
                "name": "根节点2", 
                "childList": [
                    {
                        "name": "根节点2.1", 
                        "childList": [
                            {
                                "name": "根节点2.2.1", 
                                "childList": [ ], 
                                "id": 9, 
                                "parentId": 7
                            }, 
                            {
                                "name": "根节点2.2.2", 
                                "childList": [ ], 
                                "id": 10, 
                                "parentId": 7
                            }
                        ], 
                        "id": 7, 
                        "parentId": 6
                    }, 
                    {
                        "name": "根节点2.2", 
                        "childList": [ ], 
                        "id": 8, 
                        "parentId": 6
                    }
                ], 
                "id": 6, 
                "parentId": 1
            }, 
            {
                "name": "根节点3", 
                "childList": [
                    {
                        "name": "根节点3.1", 
                        "childList": [ ], 
                        "id": 12, 
                        "parentId": 11
                    }
                ], 
                "id": 11, 
                "parentId": 1
            }
        ], 
        "id": 1, 
        "parentId": 0
    }
]
```

## 参考

- [别再写一堆的 for 循环了！Java 8 中的 Stream 轻松遍历树形结构，是真的牛逼！](https://mp.weixin.qq.com/s/obki4XsMKf-nZfScWVR6vA)