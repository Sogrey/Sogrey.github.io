---
title: web app相关整理
categories: WebApp
date: 2017-01-18 23:28:24
tags: [WebApp,手记,PPT]
---

> Webapp说白了就是一个针对Iphone、Android优化后的web站点，它使用的技术无非就是HTML或HTML5、CSS3、JavaScript，服务端技术JAVA、PHP、ASP。

# WebApp与Native App有何区别呢？

Native App：

1. 开发成本非常大。一般使用的开发语言为JAVA、C++、Objective-C。
2. 更新体验较差、同时也比较麻烦。每一次发布新的版本，都需要做版本打包，且需要用户手动更新（有些应用程序即使不需要用户手动更新，但是也需要有一个恶心的提示）。
3. 非常酷。因为native app可以调用IOS中的UI控件以UI方法，它可以实现WebApp无法实现的一些非常酷的交互效果。
4. Native app是被Apple认可的。Native app可以被Apple认可为一款可信任的独立软件，可以放在Apple Stroe出售，但是Web app却不行。

Web App：

1. 开发成本较低。使用web开发技术就可以轻松的完成web app的开发。

2. 升级较简单。升级不需要通知用户，在服务端更新文件即可，用户完全没有感觉。

3. 维护比较轻松。和一般的web一样，维护比较简单，它其实就是一个站点。

<!-- more -->
另附ppt:[github](https://github.com/Sogrey/WebApp-ppt)，[coding](https://git.coding.net/sogrey/webapp-ppt.git)

[coding预览](http://sogrey.coding.me/webapp-ppt)，[coding示例预览](http://sogrey.coding.me/webapp-ppt/example/WebApp)

[github预览](https://sogrey.github.io/WebApp-ppt/)，[github示例预览](https://sogrey.github.io/WebApp-ppt/example/WebApp)


# web app 开发经验

## 1. viewport：
也就是可视区域。对于桌面浏览器，我们都很清楚viewport是什么，就是出去了所有工具栏、状态栏、滚动条等等之后用于看网页的区域，
这是真正有效的区域。由于移动设备屏幕宽度不同于传统web,因此我们需要改变viewport;
实际上我们可以操作的属性有4 个：

	width -             //  viewport 的宽度 （范围从200 到10,000，默认为980 像素）
	height -            //  viewport 的高度 （范围从223 到10,000）
	initial-scale -     //  初始的缩放比例 （范围从>0 到10）
	minimum-scale -    //   允许用户缩放到的最小比例
	maximum-scale -    //   允许用户缩放到的最大比例
	user-scalable -    //   用户是否可以手动缩 (no,yes)

那么到底这些设置如何让Safari 知道？其实很简单，就一个meta，形如：
```
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">   //编码
<meta id="viewport" name="viewport" content="width=320; initial-scale=1.0;maximum-scale=1.0; user-scalable=no;"/>
<meta name=”apple-mobile-web-app-capable” content=”yes” />  // 离线应用的另一个技巧    
<meta name=”apple-mobile-web-app-status-bar-style” content=black” />  // 隐藏状态栏       
<meta content="black" name="apple-mobile-web-app-status-bar-style" /> //指定的iphone中safari顶端的状态条的样式       
<meta content="telephone=no" name="format-detection" />       //告诉设备忽略将页面中的数字识别为电话号码     
<meta name="Author" contect="Mr.He"/ > 
```
在设置了`initial-scale=1` 之后，我们终于可以以1:1 的比例进行页面设计了。关于viewport，还有一个很重要的概念是：iphone 的safari 浏览器完全没有滚动条，而且不是简单的“隐藏滚动条”，是根本没有这个功能。iphone 的safari 浏览器实际上从一开始就完整显示了这个网页，然后用viewport 查看其中的一部分。当你用手指拖动时，其实拖的不是页面，而是viewport。浏览器行为的改变不止是滚动条，交互事件也跟普通桌面不一样。
(请参考：指尖的下JS 系列文章)
 
## 2. link:
```
<link rel=”apple-touch-startup-image” href=”startup.png” /> // 设置开始页面图片
<link rel=”apple-touch-icon” href=”iphon_tetris_icon.png”/> // 在设置书签的时候可以显示好看的图标
<link rel="stylesheet" media="all and (orientation:portrait)" href="portrait.css">    // 肖像模式样式      
<link rel="stylesheet" media="all and (orientation:landscape)" href="landscape.css"   // 风景模式样式
//竖屏时使用的样式
<style media="all and (orientation:portrait)" type="text/css">
#landscape { display: none; }
</style>
//横屏时使用的样式
<style media="all and (orientation:landscape)" type="text/css">
#portrait { display: none; }
</style> 
```
 
## 3. 事件 ：
 (请参考：指尖的下JS 系列文章)
	// 手势事件
	touchstart            //当手指接触屏幕时触发
	touchmove           //当已经接触屏幕的手指开始移动后触发
	touchend             //当手指离开屏幕时触发
	touchcancel	// 触摸事件
	gesturestart          //当两个手指接触屏幕时触发
	gesturechange      //当两个手指接触屏幕后开始移动时触发
	gestureend	// 屏幕旋转事件  
	onorientationchange    	// 检测触摸屏幕的手指何时改变方向      
	orientationchange      	// touch事件支持的相关属性
	touches        
	targetTouches      
	changedTouches             
	clientX　　　　// X coordinate of touch relative to the viewport (excludes scroll offset)      
	clientY　　　　// Y coordinate of touch relative to the viewport (excludes scroll offset)      
	screenX　　　 // Relative to the screen       
	screenY 　　  // Relative to the screen      
	pageX　　 　　// Relative to the full page (includes scrolling)    
	pageY　　　　 // Relative to the full page (includes scrolling)    
	target　　　　 // Node the touch event originated from     
	identifier　　   // An identifying number, unique to each touch event
 
## 4. 屏幕旋转事件：onorientationchange
添加屏幕旋转事件侦听，可随时发现屏幕旋转状态（左旋、右旋还是没旋）。例子：
// 判断屏幕是否旋转
```
function orientationChange() {
    switch(window.orientation) {
    　　case 0: 
            alert("肖像模式 0,screen-width: " + screen.width + "; screen-height:" + screen.height);
            break;
    　　case -90: 
            alert("左旋 -90,screen-width: " + screen.width + "; screen-height:" + screen.height);
            break;
    　　case 90:   
            alert("右旋 90,screen-width: " + screen.width + "; screen-height:" + screen.height);
            break;
    　　case 180:   
        　　alert("风景模式 180,screen-width: " + screen.width + "; screen-height:" + screen.height);
        　　break;
    };
};
```
// 添加事件监听
```
addEventListener('load', function(){
    orientationChange();
    window.onorientationchange = orientationChange;
});
```
## 5. 隐藏地址栏 & 处理事件的时候，防止滚动条出现：
```
addEventListener('load', function(){
        setTimeout(function(){ window.scrollTo(0, 1); }, 100);
});
```
 
## 6. 双手指滑动事件：
```
addEventListener('load',　　function(){ window.onmousewheel = twoFingerScroll;},
     false   // 兼容各浏览器，表示在冒泡阶段调用事件处理程序 (true 捕获阶段)
);
function twoFingerScroll(ev) {
    var delta =ev.wheelDelta/120;              //对 delta 值进行判断(比如正负) ，而后执行相应操作
    return true;
};
```
 
## 7. 判断是否为iPhone：
```
function isAppleMobile() {
    return (navigator.platform.indexOf('iPad') != -1);
};
```

## 8. localStorage:
例子 ：（注意数据名称  n  要用引号引起来）
```
var v = localStorage.getItem('n') ? localStorage.getItem('n') : "";   // 如果名称是  n 的数据存在 ，则将其读出 ，赋予变量  v  。
localStorage.setItem('n', v);                                           // 写入名称为 n、值为  v  的数据
localStorage.removeItem('n');                                           // 删除名称为  n  的数据   
```
## 9. 使用特殊链接：
如果你关闭自动识别后 ，又希望某些电话号码能够链接到 iPhone 的拨号功能 ，那么可以通过这样来声明电话链接 ,
```
<a href="tel:12345654321">打电话给我</a>
<a href="sms:12345654321">发短信</a>
或用于单元格：
<td onclick="location.href='tel:122'">
```
## 10. 自动大写与自动修正
要关闭这两项功能，可以通过`autocapitalize` 与`autocorrect` 这两个选项：
```
<input type="text" autocapitalize="off" autocorrect="off" />
```
## 11. WebKit CSS:
①“盒模型”的具体描述性质的包围盒块内容，包括边界，填充等等。
```
-webkit-border-bottom-left-radius: radius;
-webkit-border-top-left-radius: horizontal_radius vertical_radius;
-webkit-border-radius: radius;      //容器圆角
-webkit-box-sizing: sizing_model; 边框常量值：border-box/content-box
-webkit-box-shadow: hoff voff blur color; //容器阴影（参数分别为：水平X 方向偏移量；垂直Y 方向偏移量；高斯模糊半径值；阴影颜色值）
-webkit-margin-bottom-collapse: collapse_behavior; 常量值：collapse/discard/separate
-webkit-margin-start: width;
-webkit-padding-start: width;
-webkit-border-image: url(borderimg.gif) 25 25 25 25 round/stretch round/stretch;
-webkit-appearance: push-button;   //内置的CSS 表现，暂时只支持push-button
```
②“视觉格式化模型”描述性质，确定了位置和大小的块元素。
```
direction: rtl
unicode-bidi: bidi-override; 常量：bidi-override/embed/normal
```
③“视觉效果”描述属性，调整的视觉效果块内容，包括溢出行为，调整行为，能见度，动画，变换，和过渡。
```
clip: rect(10px, 5px, 10px, 5px)
resize: auto; 常量：auto/both/horizontal/none/vertical
visibility: visible; 常量: collapse/hidden/visible
-webkit-transition: opacity 1s linear; 动画效果 ease/linear/ease-in/ease-out/ease-in-out
-webkit-backface-visibility: visibler; 常量：visible(默认值)/hidden
-webkit-box-reflect: right 1px; 镜向反转
-webkit-box-reflect: below 4px -webkit-gradient(linear, left top, left bottom,
from(transparent), color-stop(0.5, transparent), to(white));
-webkit-mask-image: -webkit-gradient(linear, left top, left bottom, from(rgba(0,0,0,1)), to(rgba(0,0,0,0)));;   //CSS 遮罩/蒙板效果
-webkit-mask-attachment: fixed; 常量：fixed/scroll
-webkit-perspective: value; 常量：none(默认)
-webkit-perspective-origin: left top;
-webkit-transform: rotate(5deg);
-webkit-transform-style: preserve-3d; 常量：flat/preserve-3d; (2D 与3D)
```
④“生成的内容，自动编号，并列出”描述属性，允许您更改内容的一个组成部分，创建自动编号的章节和标题，和操纵的风格清单的内容。
```
content: “Item” counter(section) ” “;
This resets the counter.
First section
>two section
three section
counter-increment: section 1;
counter-reset: section;
```
⑤“分页媒体”描述性能与外观的属性，控制印刷版本的网页，如分页符的行为。
```
page-break-after: auto; 常量：always/auto/avoid/left/right
page-break-before: auto; 常量：always/auto/avoid/left/right
page-break-inside: auto; 常量：auto/avoid
```
⑥“颜色和背景”描述属性控制背景下的块级元素和颜色的文本内容的组成部分。
```
-webkit-background-clip: content; 常量：border/content/padding/text
-webkit-background-origin: padding; 常量：border/content/padding/text
-webkit-background-size: 55px; 常量：length/length_x/length_y
```
⑦ “字型”的具体描述性质的文字字体的选择范围内的一个因素。报告还描述属性用于下载字体定义。
```
unicode-range: U+00-FF, U+980-9FF;
```
⑧“文本”描述属性的特定文字样式，间距和自动滚屏。
```
text-shadow: #00FFFC 10px 10px 5px;
text-transform: capitalize; 常量：capitalize/lowercase/none/uppercase
word-wrap: break-word; 常量：break-word/normal
-webkit-marquee: right large infinite normal 10s; 常量：direction(方向) increment(迭代次数) repetition(重复) style(样式) speed(速度);
-webkit-marquee-direction: ahead/auto/backwards/down/forwards/left/reverse/right/up
-webkit-marquee-incrementt: 1-n/infinite(无穷次)
-webkit-marquee-speed: fast/normal/slow
-webkit-marquee-style: alternate/none/scroll/slide
-webkit-text-fill-color: #ff6600; 常量：capitalize, lowercase, none, uppercase
-webkit-text-security: circle; 常量：circle/disc/none/square
-webkit-text-size-adjust: none; 常量:auto/none;
-webkit-text-stroke: 15px #fff;
-webkit-line-break: after-white-space; 常量：normal/after-white-space
-webkit-appearance: caps-lock-indicator;
-webkit-nbsp-mode: space; 常量： normal/space
-webkit-rtl-ordering: logical; 常量：visual/logical
-webkit-user-drag: element; 常量：element/auto/none
-webkit-user-modify: read- only; 常量：read-write-plaintext-only/read-write/read-only
-webkit-user-select: text; 常量：text/auto/none
```
⑨“表格”描述的布局和设计性能表的具体内容。
```
-webkit-border-horizontal-spacing: 2px;
-webkit-border-vertical-spacing: 2px;
-webkit-column-break-after: right; 常量：always/auto/avoid/left/right
-webkit-column-break-before: right; 常量：always/auto/avoid/left/right
–webkit-column-break-inside: logical; 常量：avoid/auto
-webkit-column-count: 3; //分栏
-webkit-column-rule: 1px solid #fff;
style:dashed,dotted,double,groove,hidden,inset,none,outset,ridge,solid
```
⑩“用户界面”描述属性，涉及到用户界面元素在浏览器中，如滚动文字区，滚动条，等等。报告还描述属性，范围以外的网页内容，如光标的标注样式和显示当您按住触摸触摸
目标，如在iPhone上的链接。
```
-webkit-box-align: baseline,center,end,start,stretch 常量：baseline/center/end/start/stretch
-webkit-box-direction: normal;常量：normal/reverse
-webkit-box-flex: flex_valuet
-webkit-box-flex-group: group_number
-webkit-box-lines: multiple; 常量：multiple/single
-webkit-box-ordinal-group: group_number
-webkit-box-orient: block-axis; 常量：block-axis/horizontal/inline-axis/vertical/orientation
–webkit-box-pack: alignment; 常量：center/end/justify/start
```
## 12. 动画过渡
这是 Webkit 中最具创新力的特性：使用过渡函数定义动画。
```
-webkit-animation: title infinite ease-in-out 3s;
animation 有这几个属性：
-webkit-animation-name： //属性名，就是我们定义的keyframes
-webkit-animation-duration：3s //持续时间
-webkit-animation-timing-function： //过渡类型：ease/ linear(线性) /ease-in(慢到快)/ease-out(快到慢) /ease-in-out(慢到快再到慢) /cubic-bezier
-webkit-animation-delay：10ms //动画延迟(默认0)
-webkit-animation-iteration-count： //循环次数(默认1)，infinite 为无限
-webkit-animation-direction： //动画方式：normal(默认 正向播放)； alternate(交替方向，第偶数次正向播放，第奇数次反向播放)
```
这些同样是可以简写的。但真正让我觉的很爽的是keyframes，它能定义一个动画的转变过程供调用，过程为0%到100%或from(0%)到to(100%)。简单点说，只要你有想法，你想让元素在这个过程中以什么样的方式改变都是很简单的。
```
-webkit-transform: 类型（缩放scale/旋转rotate/倾斜skew/位移translate）
scale(num,num) 放大倍率。scaleX 和 scaleY(3)，可以简写为：scale(* , *)
rotate(*deg) 转动角度。rotateX 和 rotateY，可以简写为：rotate(* , *)
Skew(*deg) 倾斜角度。skewX 和skewY，可简写为：skew(* , *)
translate(*,*) 坐标移动。translateX 和translateY，可简写为：translate(* , *)。
```
实现模拟弹出消息框（Alert）的例子：
①定义过渡（在`<style type="text/css">`段中描述keyframes）：
```
@-webkit-keyframes DivZoom
{
0% { -webkit-transform: scale(0.01) }
60% { -webkit-transform: scale(1.05) }
80% { -webkit-transform: scale(0.95) }
100% { -webkit-transform: scale(1.00) }
}
.sZoom { -webkit-animation: DivZoom 0.5s ease-in-out }
```
(很容易看懂，将元素从缩小的0.01 倍–很小但不能为0 倍，放大到1.05 倍，再缩小到0.95倍，最后到1倍即正常大小。整个过渡过程事件为0.5 秒，动画方式为ease-in-out，即慢到快再到慢，默认只进行1次过渡。这正是大家经常看到的 iPhone 弹出的提示信息的动画效果！）
②定义元素（在`<body>`段中）：
```
<div id="layerH" style="-webkit-border-radius:12px; border:2px solid #FFF;-webkit-box-shadow: 0px 2px 4px #888;position: absolute; left: 24px; top: 106px;<br>width: 256px; height: 268px; padding-left: 8px; padding-right: 8px;color: #FFFFFF; text-shadow: 1px 1px 1px #000; text-align: center;background-color: RGBA(32,48,96,0.9);
background-image:url('BG-Msg.png'); background-repeat:no-repeat;
z-index: 1; visibility: hidden; ">
<p><span style="font-size: 16pt; font-weight: bold">使用说明</span></p>
<hr noshade size="1">
<div id="HelpText" style="height: 120px">说明文字</div>
<hr noshade size="1">
<form name="formV" method="POST">
<input type="button" value="确认" name="B1"
style="width: 100%; height: 40px; font-size: 14pt; ont-weight: bold;
color: #FFFFFF; text-shadow: 0px -1px 1px #000;"
onclick=" layerH.style.visibility='hidden'">
</form>
</div>
```
③启动动画（在 javascript 定义的函数中）
```
function pHelp()
{
layerH.style.visibility = 'visible'
layerH.style.cssText = "-webkit-animation-delay: " + Math.random() + "ms"
layerH.className = 'sZoom'
}
```
(这个启动函数就很好理解了。但是为什么要使用-webkit-animation-delay 这句呢？因为当一个元素过渡显示完成后，若其样式没有变化，下一次将无法进行过渡动画显示。我们巧妙的利用其动画延迟时间定义，使其有所变化，就避免了上述问题。其中使用随机数函数Math.random()，产生一个大于0 小于1 的随机数。当然，延迟零点几毫秒，用户是不会察觉的。)

补充：

1.锁定 viewport
```
ontouchmove="event.preventDefault()" //锁定viewport，任何屏幕操作不移动用户界面（弹出键盘除外）。
```
2.被点击元素的外观变化，可以使用样式来设定：
```
-webkit-tap-highlight-color: 颜色
```
3.侦测iPhone/iPod
开发特定设备的移动网站，首先要做的就是设备侦测了。下面是使用Javascript侦测iPhone/iPod的UA，然后转向到专属的URL。
```
if((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i))) {
　　if (document.cookie.indexOf("iphone_redirect=false") == -1) {
　　　　window.location = "http://m.example.com";
　　}
}
```
虽然Javascript是可以在水果设备上运行的，但是用户还是可以禁用。它也会造成客户端刷新和额外的数据传输，所以下面是服务器端侦测和转向：
```
if(strstr($_SERVER['HTTP_USER_AGENT'],'iPhone') || strstr($_SERVER['HTTP_USER_AGENT'],'iPod')) {
　　header('Location: http://yoursite.com/iphone');
　　exit();
}
```
4.阻止旋转屏幕时自动调整字体大小
```
html, body, form, fieldset, p, div, h1, h2, h3, h4, h5, h6 {-webkit-text-size-adjust:none;}
```
5.iPhone才识别的CSS
如果不想设备侦测，可以用CSS媒体查询来专为iPhone/iPod定义样式。
```
@media screen and (max-device-width: 480px) {}
```
6.缩小图片
网站的大图通常宽度都超过480像素，如果用前面的代码限制了缩放，这些图片在iPhone版显示显然会超过屏幕。好在iPhone机能还够，我们可以用CSS让iPhone自动将大图片缩小显示。
```
@media screen and (max-device-width: 480px){
　　img{max-width:100%;height:auto;}
}
```
7.模拟:hover伪类
因为iPhone并没有鼠标指针，所以没有hover事件。那么CSS :hover伪类就没用了。但是iPhone有Touch事件，onTouchStart 类似 onMouseOver，onTouchEnd 类似 onMouseOut。所以我们可以用它来模拟hover。使用Javascript：
```
var myLinks = document.getElementsByTagName('a');
for(var i = 0; i < myLinks.length; i++){
　　myLinks[i].addEventListener(’touchstart’, function(){this.className = “hover”;}, false);
　　myLinks[i].addEventListener(’touchend’, function(){this.className = “”;}, false);
}
```
然后用CSS增加hover效果：
```
a:hover, a.hover { /* 你的hover效果 */ }
```
这样设计一个链接，感觉可以更像按钮。并且，这个模拟可以用在任何元素上。

# web app 开发中垒砖

当然，因为这些高端智能手机（Iphone、Android）的内置浏览器都是基于webkit内核的，所以在开发WEBAPP时，多数都是使 用 HTML5和CSS3技术做UI布局。当使用HTML5和CSS3l做UI时，若还是遵循着一般web开发中使用HTML4和CSS2那样的开发方式 的 话，这也就失去了WEBAPP的本质意义了，且有些效果也无法实现的，所以在此又回到了我们的主题–webapp的布局方式和技术。

在此所说的移动平台前端开发是指针对高端智能手机（如Iphone、Android）做站点适配也就是WebApp，并非是针对普通手机开 发 Wap 2.0，所以在阅读本篇文章以前，你需要对webkit内核的浏览器有一定的了解，你需要对HTML5和CSS3有一定的了解。

## 1.webkit内核的私有的meta标签
首先我们来看看webkit内核中的一些私有的meta标签，这些meta标签在开发webapp时起到非常重要的作用

```
<meta content=”width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;” name=”viewport” />
<meta content=”yes” name=”apple-mobile-web-app-capable” />
<meta content=”black” name=”apple-mobile-web-app-status-bar-style” />
<meta content=”telephone=no” name=”format-detection” />
```

	第一个meta标签表示：强制让文档的宽度与设备的宽度保持1:1，并且文档最大的宽度比例是1.0，且不允许用户点击屏幕放大浏览；
	
	第二个meta标签是iphone设备中的safari私有meta标签，它表示：允许全屏模式浏览；
	
	第三个meta标签也是iphone的私有标签，它指定的iphone中safari顶端的状态条的样式；
	
	第四个meta标签表示：告诉设备忽略将页面中的数字识别为电话号码。

## 2.HTML5标签的使用

在 开始编写webapp时，哥建议前端工程师使用HTML5，而放弃HTML4，因为HTML5可以实现一些HTML4中无法实现的丰富的WEB应用程 序 的体验，可以减少开发者很多的工作量，当然了你决定使用HTML5前，一定要对此非常熟悉，要知道HTML5的新标签的作用。比如定义一块内容或文章 区域 可使用section标签，定义导航条或选项卡可以直接使用nav标签等等。

## 3.放弃CSS float属性

在项目开发过程中可以会遇到内容排列排列显示的布局(见下图)，假如你遇见这样的视觉稿，哥建议你放弃float，可以直接使用display:block;

## 4.利用CSS3边框背景属性

这 个按钮有圆角效果，有内发光效果还有高光效果，这样的按钮使用CSS3写是无法写出来的，当然圆角可以使用CSS3来写，但高光和内发光却无法使 用 CSS3编写，这个时候你不妨使用-webkit-border-image来定义这个按钮的样式。-webkit-border-image就个很 复杂 的样式属性。

## 5.块级化a标签

请保证将每条数据都放在一个a标签中，为何这样做？因为在触控手机上，为提升用户体验，尽可能的保证用户的可点击区域较大。

## 6.自适应布局模式

在 编写CSS时，我不建议前端工程师把容器（不管是外层容器还是内层）的宽度定死。为达到适配各种手持设备，我建议前端工程师使用自适应布局模式（支付 宝 采用了自适应布局模式），因为这样做可以让你的页面在ipad、itouch、ipod、iphone、android、 web safarik、 chrome都能够正常的显示，你无需再次考虑设备的分辨率。

## 7.学会使用webkit-box

上一节，我们说过自适应布局模式，有些同学可能会问：如何在移动设备上做到完全自适应呢？很感谢webkit为display属性提供了一个webkit-box的值，它可以帮助前端工程师做到盒子模型灵活控制。

## 8.如何去除Android平台中对邮箱地址的识别

看 过iOS webapp API的同学都知道iOS提供了一个meta标签:用于禁用iOS对页面中电话号码的自动识别。在iOS中是不自动识别邮件 地 址的，但在Android平台，它会自动检测邮件地址，当用户touch到这个邮件地址时，Android会弹出一个框提示用户发送邮件，如果你不 想 Android自动识别页面中的邮件地址，你不妨加上这样一句meta标签在head 中 
```
 <meta content=”email=no” name=”format-detection” />
```

## 9.如何去除iOS和Android中的输入URL的控件条

你的老板或者PD或者交互设计师可能会要求你：能否让我们的webapp更加像nativeapp，我不想让用户看见那个输入url的控件条？

答案是可以做到的。我们可以利用一句简单的javascript代码来实现这个效果：

```
setTimeout(scrollTo,0,0,0);
```

请注意，这句代码必须放在`window.onload`里才能够正常的工作，而且你的当前文档的内容高度必须是高于窗口的高度时，这句代码才能有效的执行。

## 10.如何禁止用户旋转设备

我曾经也想禁止用户旋转设备，也想实现像某些客户端那样：只能在肖像模式或景观模式下才能正常运行。但现在我可以很负责任的告诉你：别想了!在移动版的webkit中做不到！

至 少Apple webapp API已经说到了：我们为了让用户在safari中正常的浏览网页，我们必须保证用户的设备处于任何一个方 位 时，safari都能够正常的显示网页内容（也就是自适应），所以我们禁止开发者阻止浏览器的`orientationchange`事件，看来苹果公司 的出 发点是正确的，苹果确实不是一般的苹果。

iOS已经禁止开发者阻止`orientationchange`事件，那Android呢？对不起，我没有找到任何资料说Android禁止开发者阻止浏览器`orientationchange`事件，但是在Android平台，确实也是阻止不了的。

## 11.如何检测用户是通过主屏启动你的webapp

看过Apple webapp API的同学都知道iOS为safari提供了一个将当前页面添加主屏的功能，按下 iphoneipodipod touch底部工具中的小加号，或者ipad顶部左侧的小加号，就可以将当前的页面添加到设备的主屏，在设备的主屏会 自动 增加一个当前页面的启动图标，点击该启动图标就可以快速、便捷的启动你的webapp。从主屏启动的webapp和浏览器访问你的webapp最大 的区别 是它清除了浏览器上方和下方的工具条，这样你的webapp就更加像是nativeapp了，还有一个区别是window对像中的 `navigator`子对 象的一个`standalone`属性。iOS中浏览器直接访问站点时，`navigator.standalone`为`false`,从 主屏启动webapp 时，`navigator.standalone`为`true`， 我们可以通过`navigator.standalone`这个属性获知 用户当前是否是从主屏访 问我们的webapp的。在Android中从来没有添加到主屏这回事！

## 12.如何关闭iOS中键盘自动大写

我 们知道在iOS中，当虚拟键盘弹出时，默认情况下键盘是开启首字母大写的功能的，根据某些业务场景，可能我们需要关闭这个功能，移动版本webkit 为 input元素提供了`autocapitalize`属性，通过指定`autocapitalize="off"`来关闭键盘默认首字母大写。

## 13.iOS中如何彻底禁止用户在新窗口打开页面

有 时我们可能需要禁止用户在新窗口打开页面，我们可以使用a标签的`target="_self"`来指定用户在新窗口打开，或者target属性保持空， 但 是你会发现iOS的用户在这个链接的上方长按3秒钟后，iOS会弹出一个列表按钮，用户通过这些按钮仍然可以在新窗口打开页面，这样的话，开发者指定 的 target属性就失效了，但是可以通过指定当前元素的`-webkit-touch-callout`样式属性为none来禁止iOS弹出这些按钮。这 个技 巧仅适用iOS对于Android平台则无效。

## 14.iOS中如何禁止用户保存图片、复制图片

我们在第13条技巧中提到元素的`-webkit-touch-callout`属性，同样为一个`img`标签指定`-webkit-touch-callout为none`也会禁止设备弹出列表按钮，这样用户就无法保存/复制你的图片了。

## 15.iOS中如何禁止用户选中文字

我们通过指定文字标签的`-webkit-user-select`属性为`none`便可以禁止iOS用户选中文字。

## 16.iOS中如何获取滚动条的值

桌 面浏览器中想要获取滚动条的值是通过`document.scrollTop`和`document.scrollLeft`得到的，但在iOS中你会发现这 两 个属性是未定义的，为什么呢？因为在iOS中没有滚动条的概念，在Android中通过这两个属性可以正常获取到滚动条的值，那么在iOS中我们该如 何获 取滚动条的值呢？

通过`window.scrollY`和`window.scrollX`我们可以得到当前窗口的y轴和x轴滚动条的值。

## 17.如何解决盒子边框溢出

当 你指定了一个块级元素时，并且为其定义了边框，设置了其宽度为100％。在移动设备开发过程中我们通常会对文本框定义为宽度100％，将其定义为块级 元 素以实现全屏自适应的样式，但此时你会发现，该元素的边框(左右)各1个像素会溢了文档，导致出现横向滚动条，为解决这一问题，我们可以为其添加一个 特殊 的样式`-webkit-box-sizing:border-box;`用来指定该盒子的大小包括边框的宽度。

## 18.如何解决Android 2.0以下平台中圆角的问题

如果大家够细心的话，在做wap站点开发时，大家应该会发现android 2.0以下的平台中问题特别的多，比如说边框圆角这个问题吧。

在对一个元素定义圆角时，为完全兼容android 2.0以下的平台，我们必须要按照以下技巧来定义边框圆角：

`-webkit`这个前缀必须要加上（在iOS中，你可以不加，但android中一定要加）；
如果对针对边框做样式定义，比如`border:1px solid #000;`那么`-webkit-border-radius`这属性必须要出现在border属性后。
假如我们有这样的视觉元素，左上角和右上角是圆角时，我们必须要先定义全局的(4个角的圆角值)`-webkit-border- radius:5px;` 然后再依次的覆盖左下角和右下角，`-webkit-border-bottom-left-radius:0;-webkit- border- bottom-right-border:0;`否则在android 2.0以下的平台中将全部显示直角，还有记住！`-webkit`这个前缀一定要加上！

## 19.如何解决android平台中页面无法自适应

虽然你的html和css都是完全自适应的，但有一天如果你发现你的页面在android中显示的并不是自适应的时候，首先请你确认你的head标签中是否包含以下meta标签：
```
<meta name=”viewport” content=”width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0;” />
```

如果有的话，那请你再仔细的看清楚有没有这个属性的值`width=device-width`，如果没有请立即加上吧！

## 20.如何解决iOS 4.3版本中safari对页面中5位数字的自动识别和自动添加样式

新的iOS系统也就是4.3版本，升级后对safari造成了一个bug：即使你添加了如下的meta标签，safari仍然会对页面中的5位连续的数字进行自动识别，并且将其重新渲染样式，也就是说你的css对该标签是无效的。
```
<meta name=”format-detection” content=”telphone=no” />
```
我们可以用一个比较龌龊的办法来解决。比如说支付宝wap站点中显示金额的标签，我们都做了如下改写：
```
<button class=”t-balance”style=”background:none;padding:0;border:0;”>95009.00</button>元
```

# 参考

http://www.25xt.com/html5css3/10261.html/comment-page-1
http://www.cnblogs.com/webapplee/p/3771716.html