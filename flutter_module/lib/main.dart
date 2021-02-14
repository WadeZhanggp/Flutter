import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/page/bill_details_page.dart';
import 'package:flutter_module/page/home_page.dart';
import 'package:flutter_module/page/login_page.dart';
import 'package:flutter_module/page/recharge_record_page.dart';
import 'package:flutter_module/page/supplier_page.dart';
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

    token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);
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
          token.toString() == null ? HomePage() : LoginPage()
      ),
      routes: {
        "home_page":(context)=> HomePage(),
        "recharge_record_page":(context) => RechargeRecordPage(),
        "supplier_page":(context) => SupplierPage(),
        "bill_details_page":(context) => BillDetailsPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}


