import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/dio/http_dio.dart';
import 'package:flutter_module/dio/http_error.dart';
import 'package:flutter_module/dio/http_manager.dart';
import 'package:flutter_module/http/core/wd_error.dart';
import 'package:flutter_module/http/dao/login_dao.dart';
import 'package:flutter_module/model/login_model.dart';
import 'package:flutter_module/page/home_page.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';
import 'package:flutter_module/utils/common_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';

import '../main.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key,this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

class _LoginPageState extends State<LoginPage> {

  final phoneController = TextEditingController();
  final passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //color: Colors.red,
              child: Container(
                alignment: const Alignment(0.0, 0.0),
                margin: const EdgeInsets.only(top: 100),
                child: Image(
                  image: AssetImage("images/img_opay_title.png"),
                  width: 80,
                  height: 162,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, top: 40),
                    child: Image(
                      image: AssetImage("images/img_phone.png"),
                      width: 16,
                      height: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 20,top: 60,right: 30),
                    child:  TextField(
                      controller: phoneController,
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: "请输入电话号码",
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),//设置提示文字样式
                        border: _underlineInputBorder,
                        focusedBorder: _underlineInputBorder,
                        enabledBorder: _underlineInputBorder,
                        disabledBorder: _underlineInputBorder,
                        focusedErrorBorder: _underlineInputBorder,
                        errorBorder: _underlineInputBorder,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, top: 40),
                    child: Image(
                      image: AssetImage("images/img_passwd.png"),
                      width: 16,
                      height: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 20,top: 60,right: 30),
                    child:  TextField(
                      controller: passwdController,
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: "请输入登录密码",
                        hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),//设置提示文字样式
                        border: _underlineInputBorder,
                        focusedBorder: _underlineInputBorder,
                        enabledBorder: _underlineInputBorder,
                        disabledBorder: _underlineInputBorder,
                        focusedErrorBorder: _underlineInputBorder,
                        errorBorder: _underlineInputBorder,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 48, top: 60, right: 48),
              width: double.infinity,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("images/img_button_bg.png"),
                    fit: BoxFit.fill
                ),
              ),
              alignment: Alignment.center,
              child: FlatButton(
                onPressed:() async {




                  String phoneNum = phoneController.text;
                  String passwd = passwdController.text;

                  send(phoneNum, passwd);
                  return;

                  if (phoneNum.isEmpty){
                    EasyLoading.showToast("请输入电话号码");
                    return;
                  }

                  if (passwd.isEmpty) {
                    EasyLoading.showToast("请输入登录密码");
                    return;
                  }

                  await EasyLoading.show(
                    maskType: EasyLoadingMaskType.black,
                  );

                  //创建时间对象，获取当前时间
                  DateTime now = new DateTime.now();

                  Map<String, dynamic> authParam = {
                    "VERSION": "1101",
                    "SOURCE": "5",
                    "REQUEST_TIME": now.toString(),
                    "LANG": 'zh',
                  };

                  Map<String, dynamic> dataParam = {
                    "MOBILE_NO": phoneNum,
                    "LOGIN_PWD": passwd,
                    "AREA_CODE": "0086",
                    "DEVICE_TYPE": 'iOS',
                    "DEVICE_TOKEN": "1234567890"
                  };

                  Map<String, dynamic> requestParam = {
                    "auth": authParam,
                    "data": dataParam,
                    "tran": "HLogin",
                  };


                  HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) {
                    print("接口返回的数据是:${value}");
                    Map loginMap = json.decode(value);
                    var login = new LoginModel.fromJson(loginMap);
                    if(login.rSPCOD == '00000'){
                      SharePreferencesUtils.saveToLocalMap(CommonUtil.TOKEN, login.dATA.sESSIONID);
                      SharePreferencesUtils.saveToLocalMap(CommonUtil.KEY, login.dATA.kEY);
                      print('请求成功');
                      EasyLoading.showToast("登录成功");

//                      Navigator.of(context)
//                          .pushNamedAndRemoveUntil(
//                      "home_page",
//                      ModalRoute.withName('/'),//清除旧栈需要保留的栈 不清除就不写这句
//                      arguments:null//传值
//                    );

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "home_page", (route) => false,//true保留跳转的当前栈   false 不保留
                      );

                    }
                  }).whenComplete(() {
                    print("异步任务处理完成");
                    EasyLoading.dismiss();
                  }).catchError((){
                    EasyLoading.dismiss();
                  });



                },
                child: Text(
                    "登录",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.transparent,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed:() async {
                      Navigator.pushNamed(context, "register_page");
                    },
                    padding: const EdgeInsets.only(left: 30, top: 40,right: 30),
                    child: Text(
                      "注册",
                      //
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void send(String userName, String password) async{
    try {
      var result = await LoginDao.login(userName, password);
      print(result);
      if (result['code'] == 0) {
        print('登录成功');

      } else {
        print(result['msg']);

      }
    } on NeedAuth catch (e) {
      print(e);

    } on WdNetError catch (e) {
      print(e);

    }
  }
}
