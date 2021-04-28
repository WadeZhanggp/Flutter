
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutterapp/db/wd_cache.dart';
import 'package:convert/convert.dart';


class CommonUtil {

  static String KEY = "key";
  static String TOKEN = "token";

  static Future<String> signatureString(Map<String, String> authMap, Map<String, String> paramsMap) async {

    var totalMap = Map();
    var orginString = "";
    totalMap["SIGN_TYPE"] = "1";//签名方式：1：MD5(默认)
    totalMap.addAll(authMap);
    if(paramsMap != null) {
      totalMap.addAll(paramsMap);
    }

    //Map<String, String> sortMap = keySort(totalMap);
    List<dynamic> allkeys = totalMap.keys.toList();
    allkeys.sort((a, b) {
      List<int> al = a.codeUnits;
      List<int> bl = b.codeUnits;
      for (int i = 0; i < al.length; i++) {
        if (bl.length <= i) return 1;
        if (al[i] > bl[i]) {
          return 1;
        } else if (al[i] < bl[i]) return -1;
      }
      return 0;
    });

    for(String key in allkeys) {
      var value = totalMap[key];
      if(orginString.length != 0) {
        orginString = orginString + "&";
      }
      orginString = orginString + key + "=" +  value;
    }

    var key = WdCache.getInstance().get("token");
    orginString = orginString + "&KEY=" + key;
    
    return generateMD5(orginString);

  }

  /// 根据request参数的key进行排序,并生成一个新的map返回
  static Map<String, String> keySort(Map<String, String> oldParamsMap) {
    Map<String, String> newParamsMap = Map();
    List<String> oldKeys = oldParamsMap.keys.toList();
    if (oldKeys.isEmpty) return newParamsMap;
    oldKeys.sort((a, b) {
      List<int> al = a.codeUnits;
      List<int> bl = b.codeUnits;
      for (int i = 0; i < al.length; i++) {
        if (bl.length <= i) return 1;
        if (al[i] > bl[i]) {
          return 1;
        } else if (al[i] < bl[i]) return -1;
      }
      return 0;
    });
    print(oldKeys);
    for (int i = 0; i < oldKeys.length; i++) {
      newParamsMap[oldKeys[i]] = oldParamsMap[oldKeys[i]];
    }
    return newParamsMap;
  }

  // 根据request参数的key进行排序,并生成一个新的map返回
  static List<String> keySortToList(Map<String, String> oldParamsMap) {
    Map<String, String> newParamsMap = Map();
    List<String> oldKeys = oldParamsMap.keys.toList();
    if (oldKeys.isEmpty) return [];
    oldKeys.sort((a, b) {
      List<int> al = a.codeUnits;
      List<int> bl = b.codeUnits;
      for (int i = 0; i < al.length; i++) {
        if (bl.length <= i) return 1;
        if (al[i] > bl[i]) {
          return 1;
        } else if (al[i] < bl[i]) return -1;
      }
      return 0;
    });
    print(oldKeys);
    return oldKeys;
  }

  // md5 加密
  static String generateMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()

    return hex.encode(digest.bytes);
  }
}