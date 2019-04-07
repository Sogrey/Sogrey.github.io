---
title: Android Webview 内容自适应高度
categories: Android
date: 2018-03-10 14:26:59
tags: [Android,Webview]
---

``` java
        webview.setWebViewClient(new WebViewClient() {
            @Override
            public void onPageFinished(WebView view, String url) {
                webview.loadUrl("javascript:App.resize(document.getElementById('chatsDataList').scrollHeight)");
                super.onPageFinished(view, url);
            }
        });
        webview.addJavascriptInterface(this, "App");
        webview.loadUrl("http://localhost:" + Constant.port + "/pages/indexCharts.html");
```
``` java
    @JavascriptInterface
    public void resize(final float height) {
        getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                TT.showToast(mContext, height + "");
                //此处的 layoutParmas 需要根据父控件类型进行区分，这里为了简单就不这么做了
                webview.setLayoutParams(new LinearLayout.LayoutParams(getResources().getDisplayMetrics().widthPixels, (int) (height * getResources().getDisplayMetrics().density)));
            }
        });
    }
```

注意：

* `chatsDataList`要修改成自己的元素
* 要运行在UI线程
* 要设置LayoutParams 
> webView.getLayoutParams().height =height;是没有用的
