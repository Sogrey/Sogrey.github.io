---
title: 封装axios网络请求
date: 2022-03-23 00:26:47
tags: [http,api]
categories: http
comments: true
toc: true
---

记录一次Vue中使用axios进行网络请求。起初封装很简单，只包含`get`和`post`两种请求接口：

``` js
// http.js
import axios from 'axios'

/**
 * get方法，对应get请求
 * @param {String} url [请求的url地址]
 * @param {Object} params [请求时携带的参数]
 */
export function get(url, params) {
    return new Promise((resolve, reject) => {
        axios.get(url, {
            params: params
        }).then(res => {
            resolve(res);
        }).catch(err => {
            reject(err)
        })
    });
}
/** 
 * post方法，对应post请求 
 * @param {String} url [请求的url地址] 
 * @param {Object} params [请求时携带的参数] 
 */
export function post(url, params) {
    return new Promise((resolve, reject) => {
        axios.post(url, QS.stringify(params))
            .then(res => {
                resolve(res);
            })
            .catch(err => {
                reject(err)
            })
    });
}
```

使用时：
``` js
import { get, post } from './http/http'

var url = 'http://localhost:10119/idiom/queryStoryByWord?word=%E6%9C%9D%E4%B8%89%E6%9A%AE%E5%9B%9B';

get(url).then((response) => {
    console.log(response)
})
```

后经过一次更新升级：

``` js
// request.js
import axios from 'axios' 
//axios响应头，直接copy官方文档
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'
//axios接口地址 本地就是localhost,使用时替换成后端的地址就行了
axios.defaults.baseURL = '//localhost:10119' 
 
//声明一个function request 用于封装axios，他接受一个url，type和data
//
export default function request(url, type = 'GET', data = {}) {
  return new Promise((resolve, reject) => {
    let option = {
      url,
      method: type,
    }
    //tolowercase转换成小写===get的话
    if(type.toLowerCase() === 'get') {
        //`params` 是即将与请求一起发送的 URL 参数
      option.params = data
      //否则的话就等于自己输入的data
    }else {
      option.data = data
    }
    //如果有token
    if(localStorage.token) {
      axios.defaults.headers.common['Authorization']  = localStorage.token
    }

    axios(option).then(res => {
      // console.log(res.data);
      
      //如果res.data.status的状态为ok且本地的token和res.data.token一样那么就resolve
      if(res.status===200 && res.data.code === 0) {
        if(res.data.token) {
          localStorage.token = res.data.token
        }
        resolve(res.data)
        //否则的话就message错误然后reject
      }else{
        reject(res.data)
      }
      //捕获异常，如果什么都不是那就网络异常
    }).catch(err => {
      reject({ msg: '网络异常:'+err })
    })
  })
} 
//使用方式  
// request('/auth/login', 'POST', {username: 'hunger', password: '123456'})
//   .then(data=>{
//     console.log(data) 
//   }) 
```
``` js
// api.js
import request from './request.js'

//直接声明一个URL存储接口地址
const URL = {
    GET_IDIOM_BY_ID: '/idiom/queryById'
};

export default {
    queryById({ id }) {
        return request(URL.GET_IDIOM_BY_ID, 'GET', { id });
    },
};
```

使用时：
``` js
import api from './http/api.js'

api.queryById({id:3506}).then(data => {
    console.log(data);
})
```

这样做的好处是后续只需要维护好业务访问接口`api.js`就好。