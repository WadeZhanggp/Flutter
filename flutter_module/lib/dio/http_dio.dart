import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_module/utils/common_data.dart';
import 'package:path_provider/path_provider.dart';

class HttpDio {

  static HttpDio instance;
  static Dio dio;

  static HttpDio getInstance() {
    if (instance == null) {
      dio = Dio();
      instance = HttpDio();
      instance.init();
    }
    return instance;
  }

  void init() async{
    //设置options
    BaseOptions options = new BaseOptions();
    //设置 header--可选--存放一些公共的请求头信息
    //Map<String, dynamic> headers = new Map();
    //options.headers = headers;
    //设置 content-type--可选
    //options.contentType = "application/x-www-form-urlencoded";
    //超时设置--可选
    options.connectTimeout = 5000;
    options.receiveTimeout = 5000;
    options.sendTimeout = 5000;
    //设置 baseurl--可选
    //options.baseUrl = "http://apis.juhe.cn";
    options.baseUrl = CommonData.appUrl;
    dio.options = options;

    //忽略Https校验
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    //dio.interceptors.add(HttpInterceptor.getInstance());

    //cookie管理--可选
    //cookie管理--获取目录需要引入path_provider库
    //Directory appDocDir = await getApplicationDocumentsDirectory();
    //String appDocPath = appDocDir.path;
    //var cookieJar = PersistCookieJar(dir: appDocPath + "/.cookies/");
    //dio.interceptors.add(PrivateCookieManager(cookieJar));

    //添加拦截器--可选
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError e) {
      return e;
    }));

    //开启请求日志--可选---要放在其他所有之后才会生效
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  /*
   * get请求
   */
  Future<dynamic> get(String url, {Map<String, dynamic> params}) async {
    Response response;
    try {
      response = await dio.get(url, queryParameters: params);
      print(response);
    } catch (e) {
      formatError(e);
    }
    return response.data;
  }

  /*
   * post请求
   */
  Future<dynamic> post(String url, {Map<String, dynamic> params}) async {
    Response response;
    try {
      response = await dio.post(url, data: params);
      print(response);
    } catch (e) {
      formatError(e);
    }
    return response.data;
  }

  /*
  * error统一处理
  */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      print("请求取消");
    } else {
      print("未知错误");
    }
  }


}