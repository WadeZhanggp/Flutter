
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
      appBar: AppBar(
        backgroundColor: ThemeColors.colorTheme,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            "关于",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 150),
        alignment: Alignment.center,
        child: Column(
          children: [
            Image(
              image: AssetImage("images/img_opay_title.png"),
              width: 80,
              height: 162,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "V1.0",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}