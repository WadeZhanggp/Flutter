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

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(

  );
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

class _HomePageState extends State<HomePage> {

  final meterNoController = TextEditingController();
  SupplierModel supplerModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child:Container(
            alignment: Alignment.center,
            child: Text('我是Drawer',style: TextStyle(fontSize: 30),),
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 300),
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
                        height: MediaQuery.of(context).size.width/750*590,
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

                                  },
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Image(
                                    image: AssetImage("images/img_home_left.png"),
                                    width: 18,
                                    height: 19,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: FlatButton(
                                  padding: const EdgeInsets.only( top: 40),
                                  child: Image(
                                    image: AssetImage("images/img_home_logo.png"),
                                    width: 68,
                                    height: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: FlatButton(
                                  onPressed:() async {
                                    //通过路由名打开新路由页
                                    Navigator.pushNamed(context, "recharge_record_page");
                                  },
                                  padding: const EdgeInsets.only( top: 40),
                                  child: Image(
                                    image: AssetImage("images/img_home_right.png"),
                                    width: 18,
                                    height: 19,
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
                      top: 150,
                      child: Container(

                        constraints: BoxConstraints.expand(
                            width: 120,
                            height: 120
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: ThemeColors.colorSelectBlue, width: 2),
                            borderRadius: BorderRadius.circular((5.0)),
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
            Column(
              children: [
                Container(
                  child: Text(
                    "付款到",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(
                      width: 200,
                      height: 45
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                        // 四个值 top right bottom left
                          bottom: BorderSide(
                            // 设置单侧边框的样式
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid))
                  ),
                  child: FlatButton(
                    onPressed:() async {

                      var result = await Navigator.pushNamed(context, "supplier_page");
                      supplerModel = result;
                      //EasyLoading.showToast(supplerModel.ELEN_NAME + supplerModel.ELEN_ID);

                    },
                    //padding: const EdgeInsets.only( top: 40),
                    child: Text(
                        supplerModel == null ? "请选择服务商" : supplerModel.ELEN_NAME,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "表号",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 200,
                  height: 44,
                  child: TextField(
                    controller: meterNoController,
                    autofocus: true,
                    //textAlign: Center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      hintText: "请输入表号",
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
                      String meterNo = meterNoController.text;
                      var token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);

                      Map<String, String> authParam = {
                        "SESSION_ID": token,
                        "SOURCE": "5",
                        "REQUEST_TIME": now.toString(),
                        "LANG": 'zh',
                      };

                      Map<String, String> dataParam = {
                        "ENEL_ID": supplerModel.ELEN_ID,
                        "METER_NO": meterNo,
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
                        "tran": "HQryMeter",
                      };

                      HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) {
                        print("接口返回的数据是:${value}");
                        Map queryMeterMap = json.decode(value);
                        var queryMeter = QueryMeterModel.fromJson(queryMeterMap);
                        queryMeter.ENEL_ID = supplerModel.ELEN_ID;
                        if(queryMeter.rSPCOD == '00000'){
                          //带参数传参
                          Navigator.pushNamed(context, "bill_details_page",arguments: queryMeter);
                        }

                      }).whenComplete(() {
                        print("异步任务处理完成");
                        EasyLoading.dismiss();
                      }).catchError((){
                        EasyLoading.dismiss();
                      });
                    },
                    child: Text(
                      "下一步",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
