---
title: Windows 10 之设置URL汇总
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
| 系统显示               | `ms-settings:display` `ms-settings:screenrotation` |           |
| 通知                   | `ms-settings:notifications`                        |           |
| 存储                   | `ms-settings:storagesense`                         |           |
| 节电模式               | `ms-settings:batterysaver`                         |           |
| 节电模式—设置          | `ms-settings:batterysaver-settings`                |           |
| 电池使用情况           | `ms-settings:batterysaver-usagedetails`            |           |
| 脱机地图               | `ms-settings:maps`                                 |           |
| 设备蓝牙               | `ms-settings:bluetooth`                            |           |
| 已连接设备             | `ms-settings:connecteddevices`                     |           |
| 鼠标和触摸版           | `ms-settings:mousetouchpad`                        |           |
| 网络与互联网电源和睡眠 | `ms-settings:powersleep`                           |           |
| 飞行模式               | `ms-settings:network-airplanemode`                 |           |
| 拨号网络               | `ms-settings:network-dialup`                       |           |
| 以太网                 | `ms-settings:network-ethernet`                     |           |
| VPN                    | `ms-settings:network-vpn`                          |           |
| 代理                   | `ms-settings:network-proxy`                        |           |
| 数据使用量             | `ms-settings:datausage`                            |           |
| Wi-Fi                  | `ms-settings:network-wifi`                         |           |
| Mobile Hotspot         | `ms-settings:network-mobilehotspot`                |           |
| 开始                   | `ms-settings:personalization-start`                |           |
| 个性化锁屏             | `ms-settings:lockscreen`                           |           |
| 个性化                 | `ms-settings:personalization`                      |           |
| 你的账户               | `ms-settings:emailandaccounts`                     |           |
| 工作单位访问           | `ms-settings:workplace`                            |           |
| 日期和时间             | `ms-settings:dateandtime`                          |           |
| 区域和语言             | `ms-settings:regionlanguage`                       |           |
| 语音                   | `ms-settings:speech`                               |           |
| 隐私日历               | `ms-settings:privacy-calendar`                     |           |
| 联系人                 | `ms-settings:privacy-contacts`                     |           |
| 反馈和诊断             | `ms-settings:privacy-feedback`                     |           |
| 位置                   | `ms-settings:privacy-location`                     |           |
| 消息传送               | `ms-settings:privacy-messaging`                    |           |
| 麦克风                 | `ms-settings:privacy-microphone`                   |           |
| 其他设备               | `ms-settings:privacy-customdevices`                |           |
| 无线电收发器           | `ms-settings:privacy-radios`                       |           |
| 语音、默迹书写和键入   | `ms-settings:privacy-speechtyping`                 |           |
| 相机                   | `ms-settings:privacy-webcam`                       |           |
| 更新和安全Windows更新  | `ms-settings:easeofaccess-closedcaptioning`        |           |
| 高对比度               | `ms-settings:easeofaccess-highcontrast`            |           |
| 放大镜                 | `ms-settings:easeofaccess-magnifier`               |           |
| 讲述人                 | `ms-settings:easeofaccess-narrator`                |           |
| 键盘                   | `ms-settings:easeofaccess-keyboard`                |           |
| 鼠标                   | `ms-settings:easeofaccess-mouse`                   |           |
| 其他选项               | `ms-settings:easeofaccess-otheroptions`            |           |

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

