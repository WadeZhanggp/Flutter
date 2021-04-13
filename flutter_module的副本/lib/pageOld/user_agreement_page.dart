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

class UserAgreementPage extends StatefulWidget {

  @override
  _UserAgreementPage createState() => _UserAgreementPage(

  );
}

class _UserAgreementPage extends State<UserAgreementPage> {


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
          title: Text("用户协议"),
        ),
        body: SingleChildScrollView(
          child: Text(
            "一、特别提示在此特别提醒您（用户）在注册成为Opay lite用户之前，请认真阅读本《用户服务协议》（以下简称“协议”），确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。您同意并点击确认本协议条款且完成注册程序后，才能成为的正式注册用户，并享受的各类服务。您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各项条款的约束。若您不同意本协议，或对本协议中的条款存在任何疑问，请您立即停止用户注册程序，并可以选择不使用本网站服务。本协议约定Opay Lite与用户之间关于服务（以下简称“服务”）的权利义务。“用户”是指注册、登录、使用本服务的个人、单位。本协议可由APP随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本APP中查阅最新版协议条款。在修改协议条款后，如果用户不接受修改后的条款，请立即停止使用提供的服务，用户继续使用提供的服务将被视为接受修改后的协议。二、账号注册1、用户在使用本服务前需要注册一个账号。“Opay Lite”账号应当使用手机号码绑定注册，请用户使用尚未与“Opay Lite”账号绑定的手机号码，以及未被根据本协议封禁的手机号码注册账号。***可以根据用户需求或产品需要对账号注册和绑定的方式进行变更，而无须事先通知用户。三、账户安全(1)含有任何性或性暗示的；（2）用户不得通过程序或人工方式转让"
          )
        )
    );
  }



}
