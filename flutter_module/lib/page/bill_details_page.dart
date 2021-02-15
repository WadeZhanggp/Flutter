import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/dio/http_dio.dart';
import 'package:flutter_module/model/create_order_model.dart';
import 'package:flutter_module/model/pre_alipay_model.dart';
import 'package:flutter_module/model/query_meter_model.dart';
import 'package:flutter_module/model/supplier_model.dart';
import 'package:flutter_module/utils/common_data.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';
import 'package:flutter_module/utils/theme_colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BillDetailsPage extends StatefulWidget {

  @override
  _BillDetailsPage createState() => _BillDetailsPage(

  );
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

class _BillDetailsPage extends State<BillDetailsPage> {


  final amountController = TextEditingController();
  var createOreder = CreateOrderModel();



  @override
  Widget build(BuildContext context) {
    /* 接收参数 */
    final QueryMeterModel queryMeter = ModalRoute.of(context).settings.arguments;
    List<String> infoNameList = ["表号","用户ID","姓名"];
    List<String> infoValueList = [queryMeter.dATA.mETERNO, queryMeter.dATA.cUSTOMERID,queryMeter.dATA.uSERNAME];

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
                          height: MediaQuery.of(context).size.width/750*490,
                          width: MediaQuery.of(context).size.width,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/img_home_nav.png"),
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
                                Expanded(
                                  flex: 1,
                                  child: FlatButton(
                                    padding: const EdgeInsets.only( top: 40,right: 50),
                                    child: Text(
                                      "缴费账户信息",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white
                                      ),
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
                        top: 100,
                        right: 20,
                        child: Container(

                          constraints: BoxConstraints.expand(
                              width: 120,
                              height: 120
                          ),
                          decoration: BoxDecoration(
                              //border: Border.all(color: ThemeColors.colorSelectBlue, width: 2),
                              borderRadius: BorderRadius.circular((60.0)),
                              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(5.0, 5.0), blurRadius: 10.0, spreadRadius: 2.0)],
                              color: Colors.white
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Image(
                                  image: AssetImage("images/img_home_electric.png"),
                                  width: 30,
                                  height: 50,
                                ),
                                padding: EdgeInsets.only(top: 15),
                              ),
                              Container(
                                child: Text(
                                  "电费",
                                  style: TextStyle(
                                    color: ThemeColors.colorSelectBlue,
                                    fontSize: 18,
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 10),
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return new Container(
                            constraints: BoxConstraints.expand(
                              //rwidth: 200,
                                height: 45
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 18),
                                    child: Text(
                                        infoNameList[index]
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 18),
                                    child: Text(
                                      infoValueList[index],
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        "请输入支付金额",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 200,
                      height: 44,
                      child: TextField(
                        controller: amountController,
                        autofocus: true,
                        //textAlign: Center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          hintText: "请输入缴费金额",
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
                    Container(
                      margin: EdgeInsets.only(top: 40),
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
                          await EasyLoading.show(
                            maskType: EasyLoadingMaskType.black,
                          );
                          //创建时间对象，获取当前时间
                          DateTime now = new DateTime.now();
                          String amount = amountController.text;
                          var token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);

                          Map<String, String> authParam = {
                            "SESSION_ID": token,
                            "SOURCE": "5",
                            "REQUEST_TIME": now.toString(),
                            "LANG": 'zh',
                          };

                          Map<String, String> dataParam = {
                            "ENEL_ID": queryMeter.ENEL_ID,
                            "METER_NO": queryMeter.dATA.mETERNO,
                            "AMT":amount
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
                            "tran": "HCreateOrd",
                          };



                          HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) {
                            print("接口返回的数据是:${value}");
                            Map createOrederMap = json.decode(value);
                            createOreder = CreateOrderModel.fromJson(createOrederMap);
                            if(queryMeter.rSPCOD == '00000'){
                              _onAlertButtonsPressed(context,"确认支付","购电金额:" + createOreder.dATA.pOWERAMT + " 服务费:" + createOreder.dATA.fEEAMT);
                            }


                          }).whenComplete(() {
                            print("异步任务处理完成");
                            EasyLoading.dismiss();
                          }).catchError((){
                            EasyLoading.dismiss();
                          });
                        },
                        child: Text(
                          "立即支付",
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
            ],
          ),
        )
    );
  }

  // Alert with multiple and custom buttons
  _onAlertButtonsPressed(context, String title, String desc) {
    Alert(
      context: context,
      type: AlertType.none,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            "取消",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.grey,
        ),
        DialogButton(
          child: Text(
            "确认",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () async{
            await EasyLoading.show(
              maskType: EasyLoadingMaskType.black,
            );
            //创建时间对象，获取当前时间
            DateTime now = new DateTime.now();
            var token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);

            Map<String, String> authParam = {
              "SESSION_ID": token,
              "SOURCE": "5",
              "REQUEST_TIME": now.toString(),
              "LANG": 'zh',
            };

            Map<String, String> dataParam = {
              "PRDORDNO": createOreder.dATA.pRDORDNO,
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
              "tran": "HPreAlipay",
            };

            HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) {
              print("接口返回的数据是:${value}");
              Map preAlipayMap = json.decode(value);
              PreAlipayModel prealipayModel = PreAlipayModel.fromJson(preAlipayMap);
              if(prealipayModel.rSPCOD == '00000'){
                
              }

            }).whenComplete(() {
              print("异步任务处理完成");
              EasyLoading.dismiss();
            }).catchError((){
              EasyLoading.dismiss();
            });
          },
          color: ThemeColors.colorTheme,
        )
      ],
    ).show();
  }
}
