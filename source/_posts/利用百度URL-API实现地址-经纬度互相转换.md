---
title: 利用百度URL API实现地址与经纬度互相转换
date: 2018-03-29 10:33:53
tags: [百度 api,地址与经纬度]
categories: api
comments: true
toc: true
---

应用中有时我们需要经纬度与地址之间互相转化，为此引入sdk又太大材小用，百度提供了这样的API可直接调用。

<!--more-->

### 1、 地址查经纬度

api:[http://lbsyun.baidu.com/index.php?title=webapi/guide/webservice-geocoding](http://lbsyun.baidu.com/index.php?title=webapi/guide/webservice-geocoding)

> http://api.map.baidu.com/geocoder/v2/?address=[地址]&output=json&mcode=[mcode]&ak=[你的AK]

例如：

http://api.map.baidu.com/geocoder/v2/?address=西安市&output=json&mcode=70:FE:DF:8B:20:BA:98:2F:21:1B:67:06:F4:3D:62:B5:7A:A5:80:AD;com.baidu.baidulocationdemo&ak=pVTtPBAsLq38z4Mm77azNU7G

* mcode 是安全码
* ak 是你在百度申请的应用的key


![百度应用ak.png](https://sogrey.github.io/pics/百度应用ak.png)


返回：

``` javascript
{
	"status": 0,
	"result": {
		"location": {
			"lng": 108.95309827919623,
			"lat": 34.277799897830629
		},
		"precise": 0,
		"confidence": 12,
		"level": "城市"
	}
}
```

### 2、经纬度查地址

api:[http://lbsyun.baidu.com/index.php?title=webapi/guide/webservice-geocoding-abroad](http://lbsyun.baidu.com/index.php?title=webapi/guide/webservice-geocoding-abroad)

> http://api.map.baidu.com/geocoder/v2/?callback=renderReverse&location=[Latitude,Longitude]&output=json&pois=1&mcode=[mcode]&ak=[你的Ak]

例如：

http://api.map.baidu.com/geocoder/v2/?callback=renderReverse&location=34.203034,108.891956&output=json&pois=1&mcode=70:FE:DF:8B:20:BA:98:2F:21:1B:67:06:F4:3D:62:B5:7A:A5:80:AD;com.baidu.baidulocationdemo&ak=pVTtPBAsLq38z4Mm77azNU7G

返回：

``` javascript
renderReverse&&renderReverse({
	"status": 0,
	"result": {
		"location": {
			"lng": 108.89195599999994,
			"lat": 34.20303403835331
		},
		"formatted_address": "陕西省西安市雁塔区丈八一路",
		"business": "",
		"addressComponent": {
			"country": "中国",
			"country_code": 0,
			"country_code_iso": "CHN",
			"country_code_iso2": "CN",
			"province": "陕西省",
			"city": "西安市",
			"city_level": 2,
			"district": "雁塔区",
			"town": "",
			"adcode": "610113",
			"street": "丈八一路",
			"street_number": "",
			"direction": "",
			"distance": ""
		},
		"pois": [{
			"addr": "丈八一路1号(跳水馆对面)",
			"cp": " ",
			"direction": "附近",
			"distance": "1",
			"name": "汇鑫IBC",
			"poiType": "房地产",
			"point": {
				"x": 108.89195610279563,
				"y": 34.20301956544281
			},
			"tag": "房地产;写字楼",
			"tel": "",
			"uid": "b703e96b79f2fc878f1a89ce",
			"zip": "",
			"parent_poi": {
				"name": "",
				"tag": "",
				"addr": "",
				"point": {
					"x": 0.0,
					"y": 0.0
				},
				"direction": "",
				"distance": "",
				"uid": ""
			}
		},
		...,
		{
			"addr": "汇鑫国际IBC国际商务中心A座",
			"cp": " ",
			"direction": "南",
			"distance": "59",
			"name": "汇鑫国际IBC国际商务中心A座",
			"poiType": "房地产",
			"point": {
				"x": 108.89182135696913,
				"y": 34.20346740878921
			},
			"tag": "房地产;写字楼",
			"tel": "",
			"uid": "5b37443de29841febbbd63f4",
			"zip": "",
			"parent_poi": {
				"name": "",
				"tag": "",
				"addr": "",
				"point": {
					"x": 0.0,
					"y": 0.0
				},
				"direction": "",
				"distance": "",
				"uid": ""
			}
		}],
		"roads": [],
		"poiRegions": [],
		"sematic_description": "汇鑫IBC附近1米",
		"cityCode": 233
	}
})
```

### java 代码：

[https://github.com/Sogrey/JavaDemo/blob/master/src/org/sogrey/url/GeoUtils.java](https://github.com/Sogrey/JavaDemo/blob/master/src/org/sogrey/url/GeoUtils.java)


### 写在最后，关于使用限制

API是免费的，但有使用上限。上面接口的使用指南可查看。


![百度api使用限制.png](https://sogrey.github.io/pics/百度api使用限制.png)
