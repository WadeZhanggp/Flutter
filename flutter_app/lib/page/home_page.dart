
import 'package:flutter/cupertino.dart';
import 'package:flutterapp/core/wd_state.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends WdState<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Text("home");
  }
}