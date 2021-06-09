import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/http/dao/bill_detail_dao.dart';
import 'package:flutterapp/http/dao/recharge_record_dao.dart';
import 'package:flutterapp/model/create_order_model.dart';
import 'package:flutterapp/model/order_detail_model.dart';
import 'package:flutterapp/model/pre_alipay_model.dart';
import 'package:flutterapp/model/query_meter_model.dart';
import 'package:flutterapp/navigator/wd_navigator.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/util/toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tobias/tobias.dart';

class BillDetailsPage extends StatefulWidget {

  //传参赋值
  final QueryMeterModel queryMeter;
  const BillDetailsPage(this.queryMeter);

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



  var createOreder = CreateOrderModel();
  String amount;



  @override
  Widget build(BuildContext context) {

    List<String> infoNameList = ["表号","用户ID","姓名"];
    List<String> infoValueList = [widget.queryMeter.dATA.mETERNO, widget.queryMeter.dATA.cUSTOMERID,widget.queryMeter.dATA.uSERNAME];

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
                              image: AssetImage("images/img_bill_bg.png"),
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
                        autofocus: true,
                        //textAlign: Center,
                        onChanged: (text){
                          amount = text;
                      },
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
                          createOrderRequest(this.amount, context);
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

  //创建订单
  void createOrderRequest(String amount ,BuildContext context) async {

    showLoading();
    var result = await BillDetailDao.createOrder(widget.queryMeter.ENEL_ID, widget.queryMeter.dATA.mETERNO,amount);
    dismissLoading();
    Map createOrderMap = json.decode(result);
    var createOrderModel = new CreateOrderModel.fromJson(createOrderMap);
    if(createOrderModel.rSPCOD == '00000'){
      showToast(createOrderModel.rSPMSG);
      _onAlertButtonsPressed(context,"确认支付","购电金额:" + createOrderModel.dATA.pOWERAMT + " 服务费:" + createOrderModel.dATA.fEEAMT, createOrderModel.dATA.pRDORDNO);
    }else {
      showToast(createOrderModel.rSPMSG);
    }

  }

  // Alert with multiple and custom buttons
  _onAlertButtonsPressed(context, String title, String desc ,String proNo) {
    Alert(
      context: context,
      type: AlertType.info,
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
            Navigator.pop(context);
            preAlipayRequest(proNo);
          },
          color: ThemeColors.colorTheme,
        )
      ],
    ).show();
  }

  _onAlertButtonsTestPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "FLAT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GRADIENT",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
        )
      ],
    ).show();
  }

  //创建订单
  void preAlipayRequest(String proNo) async {

    showLoading();
    var result = await BillDetailDao.preAlipay(proNo);
    dismissLoading();
    Map preAlipayMap = json.decode(result);
    var preAlipayModel = new PreAlipayModel.fromJson(preAlipayMap);
    if(preAlipayModel.rSPCOD == '00000'){
      showToast(preAlipayModel.rSPMSG);
      final payInfo = preAlipayModel.dATA.pAYINFO;
      Map payResult;
      try {
        //测试
        print("The pay info is : " + payInfo);
        payResult = await aliPay(payInfo);
        print("--->$payResult");
        //支付成功
        if(payResult != null && payResult["resultStatus"] == "9000"){
          showToast("支付成功");
          goDetailPage(proNo);
        }else{
          showToast("支付失败");
        }
      } on Exception catch (e) {
        payResult = {};
      }
    }else {
      showToast(preAlipayModel.rSPMSG);
    }

  }

  void goDetailPage(String proNo) async {
    showLoading();
    var result = await RechargeRecordDao.orderDetail(proNo);
    dismissLoading();
    Map rechargeDetailMap = json.decode(result);
    var detailModel = new OrderDetailModel.fromJson(rechargeDetailMap);
    if(detailModel.rSPCOD == '00000'){

      WdNavigator.getInstance().onJumpTo(RouteStatus.rechargeDetail,args: {"detailModel": detailModel});

    }else {
      showToast(detailModel.rSPMSG);
    }
  }
}
