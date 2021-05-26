import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/http/dio/http_dio.dart';
import 'package:flutterapp/http_net/request/base_request.dart';
import 'package:flutterapp/http_net/request/login_request.dart';
import 'package:flutterapp/util/common_data.dart';
import 'package:flutterapp/util/common_util.dart';
import 'package:hi_net/hi_net.dart';


class LoginDao {

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
    var result = await HiNet.getInstance().fire(request);

    print(result);

    return result;
//    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
//    return result;


  }

  static getToken() {
    return WdCache.getInstance().get(CommonUtil.TOKEN);
  }
}