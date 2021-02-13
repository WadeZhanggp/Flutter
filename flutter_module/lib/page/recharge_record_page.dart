import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/utils/theme_colors.dart';

class RechargeRecoedPage extends StatefulWidget {
  RechargeRecoedPage({Key key}) : super(key: key);

  @override
  _RechargeRecoedPage createState() => _RechargeRecoedPage(

  );
}



class _RechargeRecoedPage extends State<RechargeRecoedPage> {

  final meterNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("交易记录"),
        ),
        body: Text(
          "呵呵哒"
        )
    );
  }
}
