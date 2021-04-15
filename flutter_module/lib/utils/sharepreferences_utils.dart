import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
/// 封装SharedPreferences为单例模式
class SharePreferencesUtils{
  /// 存/更 - 进行json序列化, 均为json字符串形式保存
  /// 成功返回 Future<bool> 的成功态
  /// 失败 抛出异常信息
  static Future<dynamic> saveToLocalMap(String key, dynamic value) async {
    final com = Completer();
    final future = com.future;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonEncodestr = jsonEncode(value);
      prefs.setString(key, jsonEncodestr);
      com.complete(true);
      print('======= json序列化的待存储字符串 ======== :  ' + jsonEncodestr);
      print(' save  is  ok ,,,,,');
    } catch (err) {
      com.complete(false);
      print(' save  is  err ,,,,,');
      print(err.toString());
    }
    return future;
  }

  /// 删 - 根据key 删除对应的数据
  /// 成功返回 Future<bool> 的成功态
  /// 失败 抛出异常信息
  static Future<dynamic> deleteFromLocalMap(String key) async {
    final com = Completer();
    final future = com.future;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
      com.complete(true);
      print(' delete  is  ok ,,,,,');
    } catch (err) {
      com.complete(false);
      print(' delete  is  err ,,,,,');
      print(err.toString());
    }
    return future;
  }

  /// 取 - 读取key 对应的json序列化字符串,并进行反序列化
  /// 成功返回 Future<dynamic> 的成功对象
  /// 失败 抛出异常信息
  static Future<dynamic> readFromLocalMap(String key) async {
    final com = Completer();
    final future = com.future;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final values = prefs.get(key);
      var obj = jsonDecode(values);
      com.complete(obj);
      print('======= json反序列化后的dynamic对象 ======== :  ' + obj.toString());
      print(' read  is  ok ,,,,,');
    } catch (err) {
      // 读取失败, 仅返回一个null, 防止外部不catch,引起报错, 但是外部就需要做好判空
      com.complete(null);
      print(' read  is  err ,,,,,');
    }
    return future;
  }

}