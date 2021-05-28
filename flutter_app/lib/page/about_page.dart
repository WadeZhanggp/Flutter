
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/widget/wd_appbar.dart';

class AboutPage extends StatefulWidget{
  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();

}

class _AboutPageState extends WdState<AboutPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: WdAppBar(
          barHeight: 88,
          backgroundColor: ThemeColors.colorTheme,
          leadingWidget:  Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          centerWidget: Text(
            "关于",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          onPressedLeft: () async {
            print('点击左');
            Navigator.of(context).pop();
          }
      ),
      body: Text("About"),
    );
  }

}