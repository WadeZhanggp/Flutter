
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';

class RechargeDetailPage extends StatefulWidget{
  const RechargeDetailPage({Key key}) : super(key: key);

  @override
  _RechargeDetailPageState createState() => _RechargeDetailPageState();

}

class _RechargeDetailPageState extends WdState<RechargeDetailPage> {
  @override
  Widget build(BuildContext context) {

    return Text("充值详情");
  }

}