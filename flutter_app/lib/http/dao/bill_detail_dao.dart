
import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/http/dio/http_dio.dart';
import 'package:flutterapp/util/common_data.dart';
import 'package:flutterapp/util/common_util.dart';

class BillDetailDao {

  static createOrder(String elenid, String meterNo, String amount) {
    return _sendCreateOrder(elenid, meterNo,amount);
  }

  static preAlipay(String proNo) {
    return _sendPrealipay(proNo);
  }

  static _sendPrealipay(String proNo)async {
    //创建时间对象，获取当前时间
    DateTime now = new DateTime.now();

    String token = WdCache.getInstance().get(CommonUtil.TOKEN);
    Map<String, String> authParam = {
      "SESSION_ID": token,
      "SOURCE": "5",
      "REQUEST_TIME": now.toString(),
      "LANG": 'zh',
    };

    Map<String, String> dataParam = {
      "PRDORDNO": proNo,
    };

    //验签加密
    String signature = await CommonUtil.signatureString(authParam, dataParam);

    Map<String, String> tailParam = {
      "SIGN_TYPE":"1",
      "SIGNATURE":signature
    };

    Map<String, dynamic> requestParam = {
      "TAIL": tailParam,
      "auth": authParam,
      "data": dataParam,
      "tran": "HPreAlipay",
    };

    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
    return result;

  }

  static _sendCreateOrder(String elenid, String meterNo, String amount) async {
    //创建时间对象，获取当前时间
    DateTime now = new DateTime.now();

    String token = WdCache.getInstance().get(CommonUtil.TOKEN);

    Map<String, String> authParam = {
      "SESSION_ID": token,
      "SOURCE": "5",
      "REQUEST_TIME": now.toString(),
      "LANG": 'zh',
    };

    Map<String, String> dataParam = {
      "ENEL_ID": elenid,
      "METER_NO": meterNo,
      "AMT":amount
    };

    //验签加密
    String signature = await CommonUtil.signatureString(authParam, dataParam);

    Map<String, String> tailParam = {
      "SIGN_TYPE":"1",
      "SIGNATURE":signature
    };

    Map<String, dynamic> requestParam = {
      "TAIL": tailParam,
      "auth": authParam,
      "data": dataParam,
      "tran": "HCreateOrd",
    };


    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
    return result;
  }

}