
import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/http/dio/http_dio.dart';
import 'package:flutterapp/util/common_data.dart';
import 'package:flutterapp/util/common_util.dart';

class RechargeRecordDao {

  static orderRecord(bool onRefresh, int page, int pageSize) {
    return _send(onRefresh, page,pageSize);
  }

  static orderDetail(String proNo) {
    return _sendOrderDetailRequest(proNo);
  }


  static _sendOrderDetailRequest(String proNo) async {
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
      "PRDORDNO":proNo
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
      //
      "tran": "HOrderDetail",
    };

    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
    return result;

  }

  static _send(bool onRefresh, int page, int pageSize) async {
    int pageNum;
    if(onRefresh){
      pageNum = 1;
    }else{
      pageNum = page+1;
    }
    Map<String, dynamic> query = new Map();
    query['pageNum'] = pageNum;
    query['pageSize'] = pageSize;

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
      //"MONTH" : "202102",
      "PAGENUM": pageNum.toString()
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
      "tran": "HOrderRecord",
    };


    var result = HttpDio.getInstance().post(CommonData.appUrl, params: requestParam);
    return result;
  }

}