
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flutterapp/http/dao/register_dao.dart';
import 'package:flutterapp/model/code_model.dart';
import 'package:flutterapp/provider/theme_provider.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/util/toast.dart';
import 'package:flutterapp/widget/common_big_button.dart';
import 'package:flutterapp/widget/login_input.dart';
import 'package:flutterapp/widget/navigation_bar.dart';
import 'package:flutterapp/widget/wd_appbar.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();

}

class _RegisterPageState extends WdState<RegisterPage> {

  //定义变量
  Timer _timer;
  //倒计时数值
  var countdownTime = 0;
  String userName;
  String password;
  String smsCode;
  ThemeProvider _themeProvider;

  @override
  void initState() {
    super.initState();
    _themeProvider = context.read<ThemeProvider>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WdAppBar(
        barHeight: 88,
        backgroundColor: _themeProvider.isDark() ? WdColor.dark_bg : Colors.white,
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
                "注册",
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
      //backgroundColor: _themeProvider.isDark() ? WdColor.dark_bg : Colors.white,
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            NavigationBar(
              color: Colors.black,
              statusStyle: StatusStyle.DARK_CONTENT,
              height: 0,
            ),
            LoginInput(
              "请输入用户名",
              image: AssetImage("images/img_phone.png"),
              onChanged: (text) {
                userName = text;
              },
            ),

            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment:Alignment.center , //指定未定位或部分定位widget的对齐方式
                children: [
                  Positioned(
                    child: LoginInput(
                      "请输入验证码",
                      image: AssetImage("images/img_sms_code.png"),
                      onChanged: (text) {
                        smsCode = text;
                      },
                    ),
                  ),
                  Positioned(
                    right: 30.0,
                    bottom: -4,
                    child: TextButton(
                      onPressed: getCode,
                      child: Text(
                        handleCodeText(),
                        style: TextStyle(
                          color: ThemeColors.colorTheme,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            LoginInput(
              "请输入密码",
              image: AssetImage("images/img_passwd.png"),
              onChanged: (text) {
                password = text;
              },
            ),

            CommonBigButton(
              "注册",
              onPressed: register,
            ),
          ],
        ),
      )


    );
  }

  //获取验证码
  void getCode() async {
    print("获取验证码");
    if(countdownTime == 0) {
      startCountdown();
      showLoading();
      var result = await RegisterDao.getVerCode(userName);
      dismissLoading();
      Map codeMap = json.decode(result);
      var code = new CodeModel.fromJson(codeMap);
      if(code.rSPCOD == '00000'){
        showToast("验证码发送成功");
      }else {
        showToast(code.rSPMSG);
      }
    }
  }

  //注册
  void register() async {

    showLoading();
    var result = await RegisterDao.register(userName, password, smsCode);
    dismissLoading();
    Map registerMap = json.decode(result);
    var code = new CodeModel.fromJson(registerMap);
    if(code.rSPCOD == '00000'){
      showToast("注册成功");
    }else {
      showToast(code.rSPMSG);
    }

  }



  //倒计时方法
  startCountdown() {
    countdownTime = 60;
    final call = (timer) {
      setState(() {
        if (countdownTime < 1) {
          _timer.cancel();
        } else {
          countdownTime -= 1;
        }
      });
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

  String handleCodeText() {
    if (countdownTime > 0) {
      return "${countdownTime}s";
    } else
      return "获取验证码";
  }
}