
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';

class AboutPage extends StatefulWidget{
  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();

}

class _AboutPageState extends WdState<AboutPage> {
  @override
  Widget build(BuildContext context) {

    return Text("About");
  }

}