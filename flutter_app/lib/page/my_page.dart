
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/core/wd_state.dart';

class MyPage extends StatefulWidget{
  const MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();

}

class _MyPageState extends WdState<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Text("我的");
  }

}