
import 'package:flutter_module/db/wd_cache.dart';
import 'package:flutter_module/http/core/wd_net.dart';
import 'package:flutter_module/http/request/base_request.dart';
import 'package:flutter_module/http/request/login_request.dart';
import 'package:flutter_module/http/request/register_request.dart';

class LoginDao {

  static const Token = "token";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static _send(String userName, String password) async {

    //创建时间对象，获取当前时间
    DateTime now = new DateTime.now();

    Map<String, dynamic> authParam = {
      "VERSION": "1101",
      "SOURCE": "5",
      "REQUEST_TIME": now.toString(),
      "LANG": 'zh',
    };

    Map<String, dynamic> dataParam = {
      "MOBILE_NO": userName,
      "LOGIN_PWD": password,
      "AREA_CODE": "0086",
      "DEVICE_TYPE": 'iOS',
      "DEVICE_TOKEN": "1234567890"
    };

    Map<String, dynamic> requestParam = {
      "auth": authParam,
      "data": dataParam,
      "tran": "HLogin",
    };

    BaseRequest request;
    request = LoginRequest();
    request
        .add("auth", authParam)
        .add("data", dataParam)
        .add("tran", "HLogin");
    var result = await WdNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      //保存登录令牌
      WdCache.getInstance().setString(Token, result['data']);
    }
    return result;
  }

  static getToken() {
    return WdCache.getInstance().get(Token);
  }
}