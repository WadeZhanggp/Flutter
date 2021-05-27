
import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/http/dio/http_dio.dart';
import 'package:flutterapp/util/common_data.dart';
import 'package:flutterapp/util/common_util.dart';

class HomeDao {

  static queryMeter(String elenid, String meterNo) {
    return _send(elenid, meterNo);
  }



  static _send(String elenid, String meterNo) async {
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
      "tran": "HQryMeter",
    };

    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
    return result;
  }

}