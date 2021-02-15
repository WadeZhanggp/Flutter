import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/dio/http_dio.dart';
import 'package:flutter_module/model/create_order_model.dart';
import 'package:flutter_module/model/pre_alipay_model.dart';
import 'package:flutter_module/model/query_meter_model.dart';
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
  Widget build(BuildContext context) {
    /* 接收参数 */
    final QueryMeterModel queryMeter = ModalRoute.of(context).settings.arguments;


    return Scaffold(
        appBar: AppBar(
          title: Text("订单详情"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        )
    );
  }


}
