
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_telephone_sms/flutter_telephone_sms.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/widget/wd_appbar.dart';

class AboutPage extends StatefulWidget{
  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();

}

class _AboutPageState extends WdState<AboutPage> {

  String _platformVersion = 'Unknown';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterTelephoneSms.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

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
                "V 1.2",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                "$_platformVersion\n",
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