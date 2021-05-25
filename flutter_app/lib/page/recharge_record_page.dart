
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';

class RechargeRecordPage extends StatefulWidget{
  const RechargeRecordPage({Key key}) : super(key: key);

  @override
  _RechargeRecordPageState createState() => _RechargeRecordPageState();

}

class _RechargeRecordPageState extends WdState<RechargeRecordPage> {
  @override
  Widget build(BuildContext context) {

    return Text("充值记录");
  }

}