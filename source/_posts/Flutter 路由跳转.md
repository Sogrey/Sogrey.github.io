---
title: Flutter 路由跳转
date: 2018-11-17 14:01:21
tags: [Android,Flutter]
categories: Flutter
comments: true
toc: true
---

### 静态路由

#### 1. 注册

``` dart
    return new MaterialApp(
      title: 'Flutter 示例',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter 示例主页'),
      routes: { //静态注册路由，不能传递参数
        "SecondPage": (BuildContext context) => new Second()
      },
//      routes: <String, WidgetBuilder>{
//        // 这里可以定义静态路由，不能传递参数
//        '/router/second': (_) => new Second(),
//      },
    );
```

#### 2. 使用

``` dart
///这种路由的缺点是不能传递参数。
Navigator.pushNamed(context, "SecondPage");
```

### 动态路由

#### 有参跳转
``` dart
//跳转到新的 页面我们需要调用 navigator.push方法  -
Navigator.push(context,
new MaterialPageRoute(
    builder: (BuildContext context) {
        return new Second(title: "第二个页面");
    }
  )
);
```
#### 无参跳转
``` dart
//跳转到新的 页面我们需要调用 navigator.push方法  -
Navigator.push(
    context,
    new MaterialPageRoute(
        builder: (context) => new Second()
    )
);
```
[apk](https://github.com/Sogrey/flutter-demos/blob/master/flutter_route/apks/app-release.apk?raw=true)，[github](https://github.com/Sogrey/flutter-demos/tree/master/flutter_route)