---
title: Android混淆签名(下)
date: 2017-01-13 16:31:07
tags: [android,apk混淆,签名]
categories: Android
---

> 混淆移步[混淆](https://sogrey.github.io/article/Android%E6%B7%B7%E6%B7%86%E7%AD%BE%E5%90%8D%EF%BC%88%E4%B8%8A%EF%BC%89/)
> 
> 每个发布的应用都有自己的一个唯一合法的ID，这个就是应用自身的签名，签名可以保证你软件升级的一致性，使用相同签名的应用可以实现覆盖安装，而不一致的签名将无法共享使用数据，也即是无法覆盖安装，这样可以防止别人篡改，盗用开发者的应用，造成对开发者利益的损害。那么如何为自己的应用进行签名呢？[1](http://blog.sina.com.cn/s/blog_694394d30102vp3i.html)

<!-- more -->

# 2 apk签名

APK签名之两步走：

1. 创建一个key
2. 使用步骤1中产生的key对apk签名

## 2.1 签名文件生成
### 2.1.1 命令行生成签名文件
创建key，需要用到java的keytool.exe工具(该工具位于java环境的安装目录下jdk1.6.0_24jrebin，不同jdk版本可能略有差异)，使用产生的key对apk签名用到的是jarsigner.exe (位于安装目录下的jdk1.6.0_24bin)，如果你正确安装了java环境，并配置了正解的环境变量，那么你可以直接打开运行命令窗口输入

	C:\Users\Sogrey>keytool -genkey -alias demo.keystore -keyalg RSA -validity 40000 -keystore demo.keystore

说明： `-genkey` 产生密钥
`-alias demo.keystore` key的别名 demo.keystore
`-keyalg RSA` 使用RSA算法对签名加密
`-validity 40000` 证书有效期限4000天
`-keystore demo.keystore` 生成key的存放路径，你可以生成到指定路径（例如：D:\demo.keystore 在D盘根目录生成key文件，文件名为demo.keystor，如果不指定绝对路径将在当前cmd所在目录生成key文件）,当前我的签名文件就保存在 `C:\Users\Sogrey` 目录下。

![命令行生成签名文件](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_221026.jpg)

### 2.1.2 Eclipse生成签名文件
参见我早期的[另一篇](http://blog.sina.com.cn/s/blog_694394d30102w4i9.html)。
### 2.1.3 Android studio生成签名文件
Android studio 生成签名文件与Eclipse类似，菜单Build->Generate Signed APK ，
![Android studio生成签名文件](https://sogrey.github.io/GithubPagePics/imgs/%E5%9B%BE%E7%89%871.jpg)

弹出下面对话框：

![Android studio生成签名文件](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_223909.jpg)

点击`Create new...`,弹出下面对话框：

![Android studio生成签名文件](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_224524.jpg)

其中：

	Key store path：密钥库文件的地址 
	Password/Confirm：密钥库的密码 
	Key： 
	  Alias：密钥名称 
	  Password/Confirm：密钥密码 
	  Validity(years)：密钥有效时间 
	  First and Last Name：密钥颁发者姓名 
	  Organizational Unit：密钥颁发组织 
	  City or Locality：城市 
	  Country Code(XX)：国家 
点击`ok`,便可生成签名文件，文件路径为上面填写的`Key store path`。


## 2.2 签名apk
### 2.2.1 命令行签名apk文件

	C:\Users\Sogrey> jarsigner -verbose -keystore demo.keystore -signedjar demo_signed.apk demo.apk demo.keystore

说明： `-verbose` 输出签名的详细信息
`-keystore demo.keystore` 使用key的绝对路径，就是在第一步中生成的key
`-signedjar demor_signed.apk demo.apk demo.keystore` 正式签名，三个参数中依次为签名后产生的文件demo_signed，要签名的文件demo.apk和密钥库demo.keystore
![命令行签名apk文件](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_222555.jpg)
![命令行签名apk文件](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_222730.jpg)
### 2.2.2 Eclipse签名apk文件
参见[早期文章](http://blog.sina.com.cn/s/blog_694394d30102w4i9.html)
### 2.2.3 Android studio签名apk文件
菜单Build->Generate Signed APK,弹出框中选择`Choose existing...`,选择以创建好的签名文件。

![Android studio生成签名文件](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_223909.jpg)

输入`Key store password`,点击`Key alias`后面的`...`选择别名，再次输入别名密码，点击`next`,选择签名为debug还是release.点击`finish`即可签名完成。

![](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_225717.jpg)
![](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_230129.jpg)

# 3 查看签名
## 3.1 查看签名文件信息

	$ keytool -list -keystore debug.keystore 

结果：
	C:\Users\Sogrey\Desktop>keytool -list -keystore demo.jks
	输入密钥库口令:
	
	密钥库类型: JKS
	密钥库提供方: SUN
	
	您的密钥库包含 1 个条目
	
	demo, 2017-1-13, PrivateKeyEntry,
	证书指纹 (SHA1): 5D:2B:A2:05:8F:36:74:9C:F7:B4:A7:48:32:54:9B:6D:6C:9C:D7:9C
![](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_230705.jpg)

## 3.2 查看apk签名信息
用winrar打开待查看的apk，将其中`META-INF`文件夹解压出来，得到其中的`CERT.RSA`文件

	$ keytool -printcert -file META-INF/CERT.RSA

结果：

![](https://sogrey.github.io/GithubPagePics/imgs/2017-01-13_231453.jpg)

# 4 签名apk压缩

签名之后，用zipalign(压缩对齐)优化你的APK文件。未签名的apk不能使用，也不能优化。签名之后的apk谷歌推荐使用zipalign.exe(位于android-sdk-windowstools目录下)工具对其优化：

	C:\Users\Sogrey> zipalign -v 4 demo_signed.apk final.apk

这样，zipalign能够使apk文件中未压缩的数据在4个字节边界上对齐（一般4个字节是一个性能很好的值），这样android系统就可以使用mmap()(请自行查阅这个函数的用途)函数读取文件，可以在读取资源上获得较高的性能，

PS:

1. 在4个字节边界上对齐的意思就是指编译器把4个字节作为一个单位来进行读取的数据资源，因此，CPU能够对变量进行较之前不对齐更高效、快速的访问。
2. 对齐的根源：android系统中的Davlik虚拟机使用自己专有的格式DEX，DEX的结构是紧凑的，为了让运行时的性能更好，可以进一步用"对齐"进一步优化，但是大小一般会有所增加。


# 参考

* [android应用之——为自己的apk签名 ](http://blog.sina.com.cn/s/blog_694394d30102vp3i.html)
* [查看APK的签名的方法](http://blog.csdn.net/wed110/article/details/38303637)
* [Android如何查看应用签名信息--微信平台开发应用的签名](http://www.360doc.com/content/14/0908/05/9200790_407757027.shtml)
* [查看apk签名 和 keystore 的信息](http://janrone.com/2015/12/29/%E6%9F%A5%E7%9C%8Bapk%E7%AD%BE%E5%90%8D-%E5%92%8C-keystore-%E7%9A%84%E4%BF%A1%E6%81%AF/)
