
import 'package:flutterapp/http/dio/http_dio.dart';
import 'package:flutterapp/util/common_data.dart';

class RegisterDao {

  static register(String phone, String password, String code) {
    return _sendCode(phone, password,code);
  }

  static getVerCode(String phone) {
    return _send(phone);
  }

  static _sendCode(phone, password,code) async {
    //创建时间对象，获取当前时间
    DateTime now = new DateTime.now();

    Map<String, dynamic> authParam = {
      "VERSION": "1101",
      "SOURCE": "5",
      "REQUEST_TIME": now.toString(),
      "LANG": 'zh',
    };

    Map<String, dynamic> dataParam = {
      "MOBILE_NO": phone,
      "AREA_CODE": "0086",
      "SMS_TYPE" : "1",
      "DEVICE_TYPE": "iOS",
      "INVITATION_CODE":"0086",
      "LOGIN_PWD":password,
      "VERIFY_CODE":code,
    };

    Map<String, dynamic> requestParam = {
      "auth": authParam,
      "data": dataParam,
      "tran": "HSignup",
    };
    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
    return result;
  }

  static _send(String phone) async {

    //创建时间对象，获取当前时间
    DateTime now = new DateTime.now();

    Map<String, dynamic> authParam = {
      "VERSION": "1101",
      "SOURCE": "5",
      "REQUEST_TIME": now.toString(),
      "LANG": 'zh',
    };

    Map<String, dynamic> dataParam = {
      "MOBILE_NO": phone,
      "AREA_CODE": "0086",
      "SMS_TYPE" : "1",
    };

    Map<String, dynamic> requestParam = {
      "auth": authParam,
      "data": dataParam,
      "tran": "HSendSMSn",
    };

    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
    return result;

  }

}