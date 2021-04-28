import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/util/common_data.dart';
import 'package:flutterapp/util/log_util.dart';
import 'package:dio/src/dio_error.dart';

import 'http_error.dart';

///http请求成功回调
typedef HttpSuccessCallback<T> = void Function(dynamic data);
///失败回调
typedef HttpFailureCallback = void Function(HttpError data);
///数据解析回调
typedef T JsonParse<T>(dynamic data);



class HttpDio {

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';

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
    options.connectTimeout = 15000;
    options.receiveTimeout = 15000;
    options.sendTimeout = 15000;
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
    //添加拦截器--可选
//    dio.interceptors
//        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
//      return options;
//    }, onResponse: (Response response) {
//      return response;
//    }, onError: (DioError e) {
//      return e;
//    }));

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

  ///post网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void dioPost({
    @required String url,
    data,
    Map<String, dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback errorCallback,
    @required String tag,
  }) async {
    _request(
      url: url,
      data: data,
      method: POST,
      params: params,
      successCallback: successCallback,
      errorCallback: errorCallback,
      tag: tag,
    );
  }

  ///POST 异步网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> postAsync<T>({
    @required String url,
    data,
    Map<String, dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
    @required String tag,
  }) async {
    return _requestAsync(
      url: url,
      method: POST,
      data: data,
      params: params,
      options: options,
      jsonParse: jsonParse,
      tag: tag,
    );
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[successCallback] 请求成功回调
  ///[errorCallback] 请求失败回调
  ///[tag] 请求统一标识，用于取消网络请求
  void _request({
    @required String url,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback errorCallback,
    @required String tag,
  }) async {
    //检查网络是否连接
//    ConnectivityResult connectivityResult =
//    await (Connectivity().checkConnectivity());
//    if (connectivityResult == ConnectivityResult.none) {
//      if (errorCallback != null) {
//        errorCallback(HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
//      }
//      LogUtil.v("请求网络异常，请稍后重试！");
//      return;
//    }

    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';

    options?.method = method;

    options = options ??
        Options(
          method: method,
        );

    url = _restfulUrl(url, params);

    try {
      CancelToken cancelToken;
//      if (tag != null) {
//        cancelToken =
//        _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
//        _cancelTokens[tag] = cancelToken;
//      }

      Response<Map<String, dynamic>> response = await dio.request(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken);
      String statusCode = response.data["statusCode"];
      if (statusCode == "0") {
        //成功
        if (successCallback != null) {
          successCallback(response.data["data"]);
        }
      } else {
        //失败
        String message = response.data["statusDesc"];
        LogUtil.v("请求服务器出错：$message");
        if (errorCallback != null) {
          errorCallback(HttpError(statusCode, message));
        }
      }
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      if (errorCallback != null && e.type != DioErrorType.cancel) {
        errorCallback(HttpError.dioError(e));
      }
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      if (errorCallback != null) {
        errorCallback(HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
      }
    }
  }

  ///统一网络请求
  ///
  ///[url] 网络请求地址不包含域名
  ///[data] post 请求参数
  ///[params] url请求参数支持restful
  ///[options] 请求配置
  ///[tag] 请求统一标识，用于取消网络请求
  Future<T> _requestAsync<T>({
    @required String url,
    String method,
    data,
    Map<String, dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
    @required String tag,
  }) async {
    //检查网络是否连接
    ConnectivityResult connectivityResult =
    await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      LogUtil.v("请求网络异常，请稍后重试！");
      throw (HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后重试！"));
    }

    //设置默认值
    params = params ?? {};
    method = method ?? 'GET';

    options?.method = method;

    options = options ??
        Options(
          method: method,
        );

    url = _restfulUrl(url, params);

    try {
      CancelToken cancelToken;
//      if (tag != null) {
//        cancelToken =
//        _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
//        _cancelTokens[tag] = cancelToken;
//      }

      Response<Map<String, dynamic>> response = await dio.request(url,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);
      String statusCode = response.data["statusCode"];
      if (statusCode == "0") {
        //成功
        if (jsonParse != null) {
          return jsonParse(response.data["data"]);
        } else {
          return response.data["data"];
        }
      } else {
        //失败
        String message = response.data["statusDesc"];
        LogUtil.v("请求服务器出错：$message");
        //只能用 Future，外层有 try catch
        return Future.error((HttpError(statusCode, message)));
      }
    } on DioError catch (e, s) {
      LogUtil.v("请求出错：$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e, s) {
      LogUtil.v("未知异常出错：$e\n$s");
      throw (HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试！"));
    }
  }

  ///restful处理
  String _restfulUrl(String url, Map<String, dynamic> params) {
    // restful 请求处理
    // /gysw/search/hist/:user_id        user_id=27
    // 最终生成 url 为     /gysw/search/hist/27
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return url;
  }

  /*
  * error统一处理
  */
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      print("连接超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      print("请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      print("响应超时");
    } else if (e.type == DioErrorType.response) {
      print("出现异常");
    } else if (e.type == DioErrorType.cancel) {
      print("请求取消");
    } else {
      print("未知错误");
    }
  }


}