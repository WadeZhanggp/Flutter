import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/dio/http_dio.dart';
import 'package:flutter_module/model/code_model.dart';
import 'package:flutter_module/model/create_order_model.dart';
import 'package:flutter_module/model/order_detail_model.dart';
import 'package:flutter_module/model/pre_alipay_model.dart';
import 'package:flutter_module/model/query_meter_model.dart';
import 'package:flutter_module/model/recharge_record_model.dart';
import 'package:flutter_module/utils/common_data.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';
import 'package:flutter_module/utils/theme_colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tobias/tobias.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPage createState() => _RegisterPage();
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);


class _RegisterPage extends State<RegisterPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  final phoneController = TextEditingController();
  final passwdController = TextEditingController();
  final codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    /* 接收参数 */
    final OrderDetailModel orderDetailModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("注册"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                        image: AssetImage("images/img_code.png"),
                        width: 16,
                        height: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 20,
                      margin: const EdgeInsets.only(left: 20,top: 60,right: 10),
                      child:  TextField(
                        controller: codeController,
                        autofocus: true,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          hintText: "请输入验证码",
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
                  ),
                  Expanded(
                      flex: 0,

                      child: Container(
                        height: 20,
                          margin: const EdgeInsets.only(top: 50,right: 20),
                        child: FlatButton(
                          onPressed: () async {
                            //获取验证码
                            String phoneNum = phoneController.text;

                            if (phoneNum.isEmpty){
                              EasyLoading.showToast("请输入电话号码");
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
                              "AREA_CODE": "0086",
                              "SMS_TYPE" : "1",
                            };

                            Map<String, dynamic> requestParam = {
                              "auth": authParam,
                              "data": dataParam,
                              "tran": "HSendSMSn",
                            };

                            HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) {
                              print("接口返回的数据是:${value}");
                              Map codeMap = json.decode(value);
                              var code = new CodeModel.fromJson(codeMap);
                              if(code.rSPCOD == '00000'){
                                EasyLoading.showToast("发送成功");
                              }else {
                                EasyLoading.showToast(code.rSPMSG);
                              }

                            }).whenComplete(() {
                              print("异步任务处理完成");
                              EasyLoading.dismiss();
                            }).catchError((){
                              EasyLoading.dismiss();
                            });
                          },
                          child: Text(
                            "Get",
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColors.colorTheme
                            ),
                          ),
                        )
                      )
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
                margin: const EdgeInsets.only(left: 48, top: 40, right: 48),
                child: FlatButton(
                  onPressed: (){

                  },
                  child: Text(
                    "注册即同意用户协议"
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 48, top: 20, right: 48),
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
                    //获取验证码
                    String phoneNum = phoneController.text;
                    String codeNum = codeController.text;
                    String passwd = passwdController.text;

                    if (phoneNum.isEmpty){
                      EasyLoading.showToast("请输入电话号码");
                      return;
                    }
                    if (codeNum.isEmpty){
                      EasyLoading.showToast("请输入验证码");
                      return;
                    }
                    if (passwd.isEmpty){
                      EasyLoading.showToast("请输入密码");
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
                      "AREA_CODE": "0086",
                      "SMS_TYPE" : "1",
                      "DEVICE_TYPE": "iOS",
                      "INVITATION_CODE":"0086",
                      "LOGIN_PWD":passwd,
                      "VERIFY_CODE":codeNum,
                    };

                    Map<String, dynamic> requestParam = {
                      "auth": authParam,
                      "data": dataParam,
                      "tran": "HSignup",
                    };

                    HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) {
                      print("接口返回的数据是:${value}");
                      Map codeMap = json.decode(value);
                      var code = new CodeModel.fromJson(codeMap);
                      if(code.rSPCOD == '00000'){
                        EasyLoading.showToast("注册成功");
                        Navigator.of(context).pop();
                      }else {
                        EasyLoading.showToast(code.rSPMSG);
                      }

                    }).whenComplete(() {
                      print("异步任务处理完成");
                      EasyLoading.dismiss();
                    }).catchError((){
                      EasyLoading.dismiss();
                    });
                  },
                  child: Text(
                    "注册",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        )
    );
  }



}
