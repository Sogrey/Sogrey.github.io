---
title: Windows 10 之设置URL汇总
author: Sogrey
date: 2021-11-18 00:32:45
tags: [Windows 10]
categories: Windows
comments: true
toc: true
---

在Win10系统中系统设置其实也是一个Modern应用，它与ms-settings:协议进行了关联，在设置应用中的每一个具体的设置页面都有一个URI（统一资源标识符）与之对应，通过这些URI就可以直达某个具体的设置页面。

## 如何使用这些URI

1. 可以按Win+R打开运行，直接将URI粘贴到运行输入框回车即可；
2. 可以新建快捷方式，将URI作为对象位置键入；
3. HTML a标签href；

## 分类设置页面URI

| 设置页面               | URL                                                | a标签示例 |
| ---------------------- | -------------------------------------------------- | --------- |
| 设置页             | `ms-settings:`                                     |  <a class="a-win" href="ms-settings:">设置页</a>|
| 系统显示               | `ms-settings:display` `ms-settings:screenrotation` |<a class="a-win" href="ms-settings:display">系统显示</a>|
| 通知                   | `ms-settings:notifications`                        |<a class="a-win" href="ms-settings:notifications">通知</a>|
| 存储                   | `ms-settings:storagesense`                         |<a class="a-win" href="ms-settings:storagesense">存储</a>|
| 节电模式               | `ms-settings:batterysaver`                         |<a class="a-win" href="ms-settings:batterysaver">节电模式</a>|
| 节电模式—设置          | `ms-settings:batterysaver-settings`                |<a class="a-win" href="ms-settings:batterysaver-settings">节电模式—设置</a>|
| 电池使用情况           | `ms-settings:batterysaver-usagedetails`            |<a class="a-win" href="ms-settings:batterysaver-usagedetails">电池使用情况</a>|
| 脱机地图               | `ms-settings:maps`                                 |<a class="a-win" href="ms-settings:maps">脱机地图</a>|
| 设备蓝牙               | `ms-settings:bluetooth`                            |<a class="a-win" href="ms-settings:bluetooth">设备蓝牙</a>|
| 已连接设备             | `ms-settings:connecteddevices`                     |<a class="a-win" href="ms-settings:connecteddevices">已连接设备</a>|
| 鼠标和触摸版           | `ms-settings:mousetouchpad`                        |<a class="a-win" href="ms-settings:mousetouchpad">鼠标和触摸版</a>|
| 电源和睡眠 | `ms-settings:powersleep`                           |<a class="a-win" href="ms-settings:powersleep">电源和睡眠</a>|
| 飞行模式               | `ms-settings:network-airplanemode`                 |<a class="a-win" href="ms-settings:network-airplanemode">飞行模式</a>|
| 拨号网络               | `ms-settings:network-dialup`                       |<a class="a-win" href="ms-settings:network-dialup">拨号网络</a>|
| 以太网                 | `ms-settings:network-ethernet`                     |<a class="a-win" href="ms-settings:network-ethernet">以太网</a>|
| VPN                    | `ms-settings:network-vpn`                          |<a class="a-win" href="ms-settings:network-vpn">VPN</a>|
| 代理                   | `ms-settings:network-proxy`                        |<a class="a-win" href="ms-settings:network-proxy">代理</a>|
| 数据使用量             | `ms-settings:datausage`                            |<a class="a-win" href="ms-settings:datausage">数据使用量</a>|
| Wi-Fi                  | `ms-settings:network-wifi`                         |<a class="a-win" href="ms-settings:network-wifi">Wi-Fi</a>|
| Mobile Hotspot         | `ms-settings:network-mobilehotspot`                |<a class="a-win" href="ms-settings:network-mobilehotspot">Mobile Hotspot </a>|
| 开始                   | `ms-settings:personalization-start`                |<a class="a-win" href="ms-settings:personalization-start">开始</a>|
| 个性化锁屏             | `ms-settings:lockscreen`                           |<a class="a-win" href="ms-settings:lockscreen">个性化锁屏</a>|
| 个性化                 | `ms-settings:personalization`                      |<a class="a-win" href="ms-settings:personalization">个性化</a>|
| 你的账户               | `ms-settings:emailandaccounts`                     |<a class="a-win" href="ms-settings:emailandaccounts">你的账户</a>|
| 工作单位访问           | `ms-settings:workplace`                            |<a class="a-win" href="ms-settings:workplace">工作单位访问</a>|
| 日期和时间             | `ms-settings:dateandtime`                          |<a class="a-win" href="ms-settings:dateandtime">日期和时间</a>|
| 区域和语言             | `ms-settings:regionlanguage`                       |<a class="a-win" href="ms-settings:regionlanguage">区域和语言</a>|
| 语音                   | `ms-settings:speech`                               |<a class="a-win" href="ms-settings:speech">语音</a>|
| 隐私日历               | `ms-settings:privacy-calendar`                     |<a class="a-win" href="ms-settings:privacy-calendar">隐私日历</a>|
| 联系人                 | `ms-settings:privacy-contacts`                     |<a class="a-win" href="ms-settings:privacy-contacts">联系人</a>|
| 反馈和诊断             | `ms-settings:privacy-feedback`                     |<a class="a-win" href="ms-settings:privacy-feedback">反馈和诊断</a>|
| 位置                   | `ms-settings:privacy-location`                     |<a class="a-win" href="ms-settings:privacy-location">位置</a>|
| 消息传送               | `ms-settings:privacy-messaging`                    |<a class="a-win" href="ms-settings:privacy-messaging">消息传送</a>|
| 麦克风                 | `ms-settings:privacy-microphone`                   |<a class="a-win" href="ms-settings:privacy-microphone">麦克风</a>|
| 其他设备               | `ms-settings:privacy-customdevices`                |<a class="a-win" href="ms-settings:privacy-customdevices">其他设备</a>|
| 无线电收发器           | `ms-settings:privacy-radios`                       |<a class="a-win" href="ms-settings:privacy-radios">无线电收发器</a>|
| 语音、默迹书写和键入   | `ms-settings:privacy-speechtyping`                 |<a class="a-win" href="ms-settings:privacy-speechtyping">语音、默迹书写和键入</a>|
| 相机                   | `ms-settings:privacy-webcam`                       |<a class="a-win" href="ms-settings:privacy-webcam">相机</a>|
| 隐藏式字幕  | `ms-settings:easeofaccess-closedcaptioning`        |<a class="a-win" href="ms-settings:easeofaccess-closedcaptioning">隐藏式字幕</a>|
| 高对比度               | `ms-settings:easeofaccess-highcontrast`            |<a class="a-win" href="ms-settings:easeofaccess-highcontrast">高对比度</a>|
| 放大镜                 | `ms-settings:easeofaccess-magnifier`               |<a class="a-win" href="ms-settings:easeofaccess-magnifier">放大镜</a>|
| 讲述人                 | `ms-settings:easeofaccess-narrator`                |<a class="a-win" href="ms-settings:easeofaccess-narrator">讲述人</a>|
| 键盘                   | `ms-settings:easeofaccess-keyboard`                |<a class="a-win" href="ms-settings:easeofaccess-keyboard">键盘</a>|
| 鼠标                   | `ms-settings:easeofaccess-mouse`                   |<a class="a-win" href="ms-settings:easeofaccess-mouse">鼠标</a>|
| 其他选项               | `ms-settings:easeofaccess-otheroptions`            |<a class="a-win" href="ms-settings:easeofaccess-otheroptions">其他选项</a>|

<style>a.a-win{color: #fff;
    background: #fe7300;padding: 6px 20px;
    font-weight: 500;
    line-height: 24px;
    font-size: 18px;
    margin: 5px auto;
    border-radius: 2px;-webkit-box-shadow: 0px 0em 0px 0px rgb(39 41 43 / 15%) inset;
    box-shadow: 0px 0em 0px 0px rgb(39 41 43 / 15%) inset;text-shadow: none;cursor: pointer;
    display: inline-block;
    min-height: 1em;
    outline: none;
    border: none;
    vertical-align: baseline;}</style>

