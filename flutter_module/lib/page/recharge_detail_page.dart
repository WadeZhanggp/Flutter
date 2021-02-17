import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/dio/http_dio.dart';
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

class RechargeDetailPage extends StatefulWidget {

  @override
  _RechargeDetailPage createState() => _RechargeDetailPage(

  );
}

class _RechargeDetailPage extends State<RechargeDetailPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    /* 接收参数 */
    final OrderDetailModel orderDetailModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("订单详情"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("images/img_pay_success.png"),
                  height: 73,
                  width: 73,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 10,left: 20),
                child: Text(
                  "Token",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  orderDetailModel.dATA.tOKEN,
                  style: TextStyle(
                    fontSize: 24,
                    color: ThemeColors.colorTheme
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 10,left: 20),
                child: Text(
                  "支付金额",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "RMB " + orderDetailModel.dATA.tRANAMT,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.green
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }



}
