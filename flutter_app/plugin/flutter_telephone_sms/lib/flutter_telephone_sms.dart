
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterTelephoneSms {
  static const MethodChannel _channel =
      const MethodChannel('flutter_telephone_sms');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void callPhone(String phoneNumber) async {
     _channel.invokeMethod('callPhone',{"phoneNumber":phoneNumber});
  }
}
