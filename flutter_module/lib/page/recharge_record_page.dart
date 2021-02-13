import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/utils/theme_colors.dart';

class RechargeRecordPage extends StatefulWidget {
  RechargeRecordPage({Key key}) : super(key: key);

  @override
  _RechargeRecordPage createState() => _RechargeRecordPage(

  );
}



class _RechargeRecordPage extends State<RechargeRecordPage> {

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
