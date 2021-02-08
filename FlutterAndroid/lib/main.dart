import 'package:flutter/material.dart';
import 'package:flutteropay/page/home_page.dart';
import 'package:flutteropay/page/login_page.dart';

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
      home: LoginPage(),
      routes: {
        "home_page":(context)=> HomePage(),
      },
    );
  }
}


