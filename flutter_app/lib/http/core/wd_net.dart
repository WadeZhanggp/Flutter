

import 'package:flutterapp/http/core/wd_error.dart';
import 'package:flutterapp/http/core/wd_interceptor.dart';
import 'package:flutterapp/http/core/wd_net_adapter.dart';
import 'package:flutterapp/http/request/base_request.dart';

import 'dia_adapter.dart';

///1.支持网络库插拔设计，且不干扰业务层
///2.基于配置请求请求，简洁易用
///3.Adapter设计，扩展性强
///4.统一异常和返回处理
class WdNet {
  WdNet._();

  WdErrorInterceptor _hiErrorInterceptor;
  static WdNet _instance;

  static WdNet getInstance() {
    if (_instance == null) {
      _instance = WdNet._();
    }
    return _instance;
  }

  Future fire(BaseRequest request) async {
    WdNetResponse response;
    var error;
    try {
      response = await send(request);
    } on WdNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response.data;
    printLog(result);
    var status = response.statusCode;
    var hiError;
    switch (status) {
      case 200:
        return result;
        break;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      default:
        hiError = WdNetError(status, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_hiErrorInterceptor != null) {
      _hiErrorInterceptor(hiError);
    }
    throw hiError;
  }

  Future<WdNetResponse<T>> send<T>(BaseRequest request) async {
    ///使用Dio发送请求
    WdNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void setErrorInterceptor(WdErrorInterceptor interceptor) {
    this._hiErrorInterceptor = interceptor;
  }

  void printLog(log) {
    print('hi_net:' + log.toString());
  }
}