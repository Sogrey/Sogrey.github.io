---
title: 网站更新日志
date: 2017-01-11 11:55:46
---

> 此处记录本站的主题和网站配置更新和修改以备忘，不包含发布新文章、修改文章。

## 2020-11-28

| 序号 | 修改内容                                                     | 描述             | 文件位置                                                     |
| ---- | ------------------------------------------------------------ | ---------------- | ------------------------------------------------------------ |
| 1    |[由于gitment域名过期，无奈切换到gitalk](https://sogrey.top/article/Hexo-%E6%B7%BB%E5%8A%A0-Gitment-%E8%AF%84%E8%AE%BA/#7-%E7%94%B1%E4%BA%8Egitment%E5%9F%9F%E5%90%8D%E8%BF%87%E6%9C%9F%EF%BC%8C%E6%97%A0%E5%A5%88%E5%88%87%E6%8D%A2%E5%88%B0gitalk) | gitment域名过期导致不能授权 | `themes\yelog\layout\_partial\gitalk.ejs` |

## 2018-11-02

| 序号 | 修改内容                                                     | 描述             | 文件位置                                                     |
| ---- | ------------------------------------------------------------ | ---------------- | ------------------------------------------------------------ |
| 1    | [第一步]需将`after-footer.ejs`文件里 `<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>` 修改为 `<script async src="//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>` ,[第二步]修改`footer.ejs` 参见 [issues](https://github.com/yscoder/hexo-theme-indigo/issues/430),[不蒜子](http://ibruce.info/2015/04/04/busuanzi/),[第三步]配置主题下`_config.yml`: `visit_counter:  on: true  site_visit: true  page_visit: true`(注意缩进格式) | 不蒜子域名过期了 | `themes\yelog\layout\_partial\after-footer.ejs`和`themes\yelog\layout\_partial\footer.ejs`,`themes\_config.yml` |

## 2017-01-13

序号 | 修改内容 | 描述 | 文件位置
----|---------|-----|-------
1 | `toc-top=378px`->`toc-top=308px`  | 修改主题yelog左边个人信息栏文章目录高度 | `themes\yelog\source\css\_variables.styl line:73`

## 2017-01-11

序号 | 修改内容 | 描述 | 文件位置
----|---------|-----|-------
1 | `height: 180px;` -> `height: 100px;`  | 修改主题yelog左边个人信息栏顶部背景高度(偶尔修改后由于缓存不生效，删除`.deploy_git`目录下除`.git`外其他文件文件夹，`hexo d`使其重新生成) | `yelog\source\css\_partial\main.styl line:48`
2 | `margin: 112px auto 0;` -> `margin: 32px auto 0;` | 修改主题yelog左边个人信息栏内容居顶距离(不生效可尝试上条重新部署)| `yelog\source\css\_partial\main.styl line:56`
3 | 主题`_config.yml`>`menu`>增加`更新日志: /logs/` | 修改主题yelog左边个人信息栏 菜单增加`更新日志` 项,即本页 | `yelog\_config.yml line:15`
4 |[hexo-generator-search](https://github.com/PaicHyperionDev/hexo-generator-search);<br/> `yelog\_config.yml line:232`处 `search.on`: false -> true;| 站点增加搜索功能 | `yelog\_config.yml line:232`,`themes\yelog\layout\_partial\left-col.ejs line:15-22`


	                   _ooOoo_
	                  o8888888o
	                  88" . "88
	                  (| -_- |)
	                   O\ = /O
	               ____/`---'\____
	             .   ' \\| |// `.
	              / \\||| : |||// \
	            / _||||| -:- |||||- \
	              | | \\\ - /// | |
	            | \_| ''\---/'' | |
	             \ .-\__ `-` ___/-. /
	          ___`. .' /--.--\ `. . __
	       ."" '< `.___\_<|>_/___.' >'"".
	      | | : `- \`.;`\ _ /`;.`/ - ` : | |
	        \ \ `-. \_ __\ /__ _/ .-` / /
	======`-.____`-.___\_____/___.-`____.-'======
	                   `=---='
	
	.............................................
	         佛祖保佑             永无BUG
	
	 佛曰:
	         写字楼里写字间，写字间里程序员；
	         程序人员写程序，又拿程序换酒钱。
	         酒醒只在网上坐，酒醉还来网下眠；
	         酒醉酒醒日复日，网上网下年复年。
	         但愿老死电脑间，不愿鞠躬老板前；
	         奔驰宝马贵者趣，公交自行程序员。
	         别人笑我忒疯癫，我笑自己命太贱；
	         不见满街漂亮妹，哪个归得程序员？
	
	                   .::::.
	                 .::::::::.
	                :::::::::::
	            ..:::::::::::'
	          '::::::::::::'
	            .::::::::::
	       '::::::::::::::..
	            ..::::::::::::.
	          ``::::::::::::::::
	           ::::``:::::::::'        .:::.
	          ::::'   ':::::'       .::::::::.
	        .::::'      ::::     .:::::::'::::.
	       .:::'       :::::  .:::::::::' ':::::.
	      .::'        :::::.:::::::::'      ':::::.
	     .::'         ::::::::::::::'         ``::::.
	 ...:::           ::::::::::::'              ``::.
	```` ':.          ':::::::::'                  ::::..
	                   '.:::::'                    ':'````..

图案来源：[神注释大全（欢迎补充）](http://www.jianshu.com/p/bd1f551a1915?utm_campaign=haruki&utm_content=note&utm_medium=reader_share&utm_source=qq)
