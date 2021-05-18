import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

///错误提示样式的toast
void showWarnToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey,
      textColor: Colors.white);
}


///普通提示样式的toast
void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
  );
}

///
void showLoading(){
  EasyLoading.show(status: 'loading...');
}

void dismissLoading(){
  EasyLoading.dismiss();
}
