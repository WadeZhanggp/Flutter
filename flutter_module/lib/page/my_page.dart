import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/dio/http_dio.dart';
import 'package:flutter_module/model/query_meter_model.dart';
import 'package:flutter_module/model/supplier_model.dart';
import 'package:flutter_module/utils/common_data.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';
import 'package:flutter_module/utils/theme_colors.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState(

  );
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

class _MyPageState extends State<MyPage> {

  final meterNoController = TextEditingController();
  SupplierModel supplerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Column(

            children: [
              ConstrainedBox(
                constraints: BoxConstraints.expand(height: 200),
                child: Stack(
                  alignment:Alignment.center,
                  //overflow：此属性决定如何显示超出Stack显示空间的子组件；值为Overflow.clip时，超出部分会被剪裁（隐藏），值为Overflow.visible 时则不会。
                  overflow: Overflow.visible,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        //设置背景图片
                        constraints: BoxConstraints.expand(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/img_head_bg.png"),
                              fit:BoxFit.cover,
                            )
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: FlatButton(
                                    onPressed:() async {
                                      Navigator.of(context).pop();
                                    },
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Image(
                                      image: AssetImage("images/img_home_back.png"),
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),

                              ],

                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top:40,
                        child: Text(
                          "我的",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                          ),
                        )
                    ),
                    Positioned(
                        top: 90,
                        child: Container(
                          width: 62,
                          height: 62,
                          child: Image(
                            image: AssetImage("images/img_my_header.png"),
                          ),
                        )
                    ),
                    Positioned(
                        top: 170,
                        child: Container(
                          height: 20,
                          child: Text(
                            "user 3503",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white
                            ),
                          ),
                        )
                    ),

                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 240),
                    width: 200,
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
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "login_page", (route) => false,//true保留跳转的当前栈   false 不保留
                        );
                      },
                      child: Text(
                        "退出登录",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}
