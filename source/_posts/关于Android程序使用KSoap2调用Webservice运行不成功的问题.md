---
title: 关于Android程序使用KSoap2调用Webservice运行不成功的问题
date: 2018-03-26 18:30:11
tags: [Android,KSoap2,Webservice]
categories: Android
comments: true
toc: true
---

公司的一个旧项目，用到了KSoap2访问Webservice，再编译运行时报`android.os.NetworkOnMainThreadException`异常。

<!-- more -->

原代码：

``` java

import java.io.IOException;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;
import org.xmlpull.v1.XmlPullParserException;

import android.os.AsyncTask;
import android.os.Handler;
import android.util.Log;

public class Service_conn {
    String TAG = this.getClass().getSimpleName();
    private static final String NAMESPACE = "WebService";
    SoapObject soap_request;
    HttpTransportSE ht;
    SoapSerializationEnvelope envelope;
    private SoapObject soap_result = null;


    /**
     * 向服务器发送请求
     *
     * @param method_name
     * @param param
     * @return
     * @throws IOException
     * @throws XmlPullParserException
     */
    public SoapObject SEND_MESSAGE(final String method_name, List<NameValue> param) throws Exception {
        soap_request = new SoapObject(NAMESPACE, method_name);
        if (param != null) {
            for (int i = 0; i < param.size(); i++) {
                Log.e(TAG, "参数：" + param.get(i).getName() + "=" + param.get(i).getValue());
                soap_request.addProperty(param.get(i).getName(), param.get(i).getValue());
            }
        }
        envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
//		envelope.bodyOut = soap_request;//此句导致参数发送不到服务器
        envelope.dotNet = true;//webservice不指定rpc方式则用true否则要用false(也会导致参数发送不到服务器)
        envelope.setOutputSoapObject(soap_request);
        ht = new HttpTransportSE(SocketService.URL);
        ht.debug = true;
        Log.e(TAG, "URL:" + SocketService.URL + "   NAMESPACE:" + NAMESPACE + "    method_name:" + method_name);

        ht.call(NAMESPACE+"/"+method_name, envelope);// <-- 问题出在这里
        soap_result = (SoapObject) envelope.bodyIn;
        return soap_result;
    }
}

```

从Honeycomb SDK（3.0）开始，google不再允许网络请求（HTTP、Socket）等相关操作直接在Main Thread类中。既然不允许放在主线程那就另开线程执行，但这样结果要跑回主线程就要通过 interface 回调跑回主线程，进而所有调用该方法的方法都要加一 interface 参数，这样改动太大了。

在Java中一般通过继承Thread类或者实现Runnable接口这两种方式来创建多线程，但是这两种方式都有个缺陷，就是不能在执行完成后获取执行的结果，因此Java 1.5之后提供了Callable和Future接口，通过它们就可以在任务执行完毕之后得到任务的执行结果。

``` java
        FutureTask<SoapObject> futureTask = new FutureTask<SoapObject>(
                new Callable<SoapObject>() {
                    @Override
                    public SoapObject call() throws Exception {
                        try {
                            // 调用WebService
                            ht.call(NAMESPACE + "/" + method_name, envelope);
                            if (envelope.getResponse() != null) {
                                // 获取返回的数据
                                SoapObject object = (SoapObject) envelope.bodyIn;
                                // 获取返回的结果
                                String result = object.getProperty(0)
                                        .toString();
                                LogUtil.E("Service_conn", result);
                                return object;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        return null;
                    }
                });
        new Thread(futureTask).start();
        try {
            soap_result = futureTask.get();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
```

这样不需要在回调中获取结果。

最终代码：

``` java
import java.io.IOException;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;
import org.xmlpull.v1.XmlPullParserException;

import android.os.AsyncTask;
import android.os.Handler;
import android.util.Log;

public class Service_conn {
    String TAG = this.getClass().getSimpleName();
    private static final String NAMESPACE = "WebService";
    SoapObject soap_request;
    HttpTransportSE ht;
    SoapSerializationEnvelope envelope;
    private SoapObject soap_result = null;


    /**
     * 向服务器发送请求
     *
     * @param method_name
     * @param param
     * @return
     * @throws IOException
     * @throws XmlPullParserException
     */
    public SoapObject SEND_MESSAGE(final String method_name, List<NameValue> param) throws Exception {
        soap_request = new SoapObject(NAMESPACE, method_name);
        if (param != null) {
            for (int i = 0; i < param.size(); i++) {
                Log.e(TAG, "参数：" + param.get(i).getName() + "=" + param.get(i).getValue());
                soap_request.addProperty(param.get(i).getName(), param.get(i).getValue());
            }
        }
        envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
//		envelope.bodyOut = soap_request;//此句导致参数发送不到服务器
        envelope.dotNet = true;//webservice不指定rpc方式则用true否则要用false(也会导致参数发送不到服务器)
        envelope.setOutputSoapObject(soap_request);
        ht = new HttpTransportSE(SocketService.URL);
        ht.debug = true;
        Log.e(TAG, "URL:" + SocketService.URL + "   NAMESPACE:" + NAMESPACE + "    method_name:" + method_name);

//        ht.call(NAMESPACE+"/"+method_name, envelope);// <-- 问题出在这里
//        soap_result = (SoapObject) envelope.bodyIn;
        FutureTask<SoapObject> futureTask = new FutureTask<SoapObject>(
                new Callable<SoapObject>() {
                    @Override
                    public SoapObject call() throws Exception {
                        try {
                            // 调用WebService
                            ht.call(NAMESPACE + "/" + method_name, envelope);
                            if (envelope.getResponse() != null) {
                                // 获取返回的数据
                                SoapObject object = (SoapObject) envelope.bodyIn;
                                // 获取返回的结果
                                String result = object.getProperty(0)
                                        .toString();
                                LogUtil.E("Service_conn", result);
                                return object;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        return null;
                    }
                });
        new Thread(futureTask).start();
        try {
            soap_result = futureTask.get();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
        return soap_result;
    }
}
```