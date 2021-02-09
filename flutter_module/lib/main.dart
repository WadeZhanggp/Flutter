import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/page/home_page.dart';
import 'package:flutter_module/page/login_page.dart';


void main() => runApp(MyApp());

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
      home: LoginPage(title: 'test'),
      routes: {
        "home_page":(context)=> HomePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}


