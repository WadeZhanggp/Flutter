import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/pageOld//bill_details_page.dart';
import 'package:flutter_module/pageOld/home_page.dart';
import 'package:flutter_module/pageOld/login_page.dart';
import 'package:flutter_module/pageOld/my_page.dart';
import 'package:flutter_module/pageOld/recharge_detail_page.dart';
import 'package:flutter_module/pageOld/recharge_record_page.dart';
import 'package:flutter_module/pageOld/register_page.dart';
import 'package:flutter_module/pageOld/supplier_page.dart';
import 'package:flutter_module/pageOld/user_agreement_page.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';


//void main() => runApp(
//    MyApp(),
//);
void main() {
  runApp(MyApp());
  configLoading();
}

var token;

Future<void> configLoading() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

    token = SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);
    print("token " + token);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Opay',
      debugShowCheckedModeBanner: false,//去除debug水印
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (
          token.toString() != null ? HomePage() : LoginPage()
      ),
      routes: {
        "home_page":(context)=> HomePage(),
        "recharge_record_page":(context) => RechargeRecordPage(),
        "supplier_page":(context) => SupplierPage(),
        "bill_details_page":(context) => BillDetailsPage(),
        "recharge_detail_page":(context) => RechargeDetailPage(),
        "my_page":(context) => MyPage(),
        "login_page":(context) => LoginPage(),
        "register_page":(context) => RegisterPage(),
        "user_agreement":(context) => UserAgreementPage()
      },
      builder: EasyLoading.init(),
    );
  }
}


