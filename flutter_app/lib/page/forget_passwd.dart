
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/widget/navigation_bar.dart';
import 'package:flutterapp/widget/wd_appbar.dart';

class ForgetPasswdPage extends StatefulWidget{
  const ForgetPasswdPage({Key key}) : super(key: key);

  @override
  _ForgetPasswdPageState createState() => _ForgetPasswdPageState();

}

class _ForgetPasswdPageState extends WdState<ForgetPasswdPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WdAppBar(
          barHeight: 88,
          backgroundColor: Colors.white,
          leadingWidget:  Row(
            children: [
              Image(
                image: AssetImage("images/img_login_back.png"),
                width: 20,
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 12),
                child: Text(
                  "忘记密码",
                  style: TextStyle(
                    fontSize: 24,
                    color: ThemeColors.colorTheme,
                  ),
                ),
              )
            ],
          ),
          onPressedLeft: () async {
            print('点击左');
            Navigator.of(context).pop();
          }
      ),
      backgroundColor: Colors.white,
      body: //iOS 黑色状态栏
      NavigationBar(
        color: Colors.black,
        statusStyle: StatusStyle.DARK_CONTENT,
        height: 0,
      ),
    );
  }
}