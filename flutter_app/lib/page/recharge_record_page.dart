
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flukit/flukit.dart';
import 'package:flutterapp/http/dao/login_dao.dart';
import 'package:flutterapp/http/dao/recharge_record_dao.dart';
import 'package:flutterapp/model/order_detail_model.dart';
import 'package:flutterapp/model/recharge_record_model.dart';
import 'package:flutterapp/navigator/wd_navigator.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/util/toast.dart';
import 'package:flutterapp/widget/custom_pullrefresh_header.dart';
import 'package:flutterapp/widget/recharge_record_item.dart';
import 'package:flutterapp/widget/wd_appbar.dart';


class RechargeRecordPage extends StatefulWidget{
  const RechargeRecordPage({Key key}) : super(key: key);

  @override
  _RechargeRecordPageState createState() => _RechargeRecordPageState();

}

class _RechargeRecordPageState extends WdState<RechargeRecordPage> {

  int _current = 0;

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
          "充值记录",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: InfiniteListView<TRANRECORD>(
        itemBuilder: (List list, int index, BuildContext ctx) {
          return RechargeRecordItem(
              list[index].tRANDATE,
              list[index].tRANAMT,
              list[index].oRDSTATUS,
              onTap: (){
                print("点击数组位置$index");
                TRANRECORD tranrecord = list[index];
                goDetailPage(tranrecord.pRDORDNO);

            },
          );
        },
        onRetrieveData: (int page, List items, bool refresh) async {

          int start = _current;

          var result = await RechargeRecordDao.orderRecord(refresh, start, 10);

          Map rechargeRecordMap = json.decode(result);
          var rechargeRecordModel = new RechargeRecordModel.fromJson(rechargeRecordMap);
          if(rechargeRecordModel.rSPCOD == '00000'){
            List list = rechargeRecordMap['DATA']["TRAN_RECORD"] as List;

            if (list == null || list.length == 0) {
              return false;
            }
            List<TRANRECORD> tranList = list.map((i) => TRANRECORD.fromJson(i)).toList();
            if(refresh){

              print("刷新");
              //如果是下拉数显
              _current = start = 0;
              items.clear();
              items.addAll(tranList);
              return tranList.length < 10 ? false : true;
            }else {
              _current += 1;
              print("加载更多");
              items.addAll(tranList);
              return tranList.length < 10 ? false : true;;
            }


          }else {
            showToast(rechargeRecordModel.rSPMSG);
            return false;
          }

        },
        loadingBuilder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedRotationBox(
                  duration: Duration(milliseconds: 800),
                  child: GradientCircularProgressIndicator(
                    radius: 10.0,
                    colors: [Colors.blue, Colors.lightBlue[50]],
                    value: .8,
                    backgroundColor: Colors.transparent,
                    strokeCapRound: true,
                  ),
                ),
                Text("  加载更多...")
              ],
            ),
          );
        },
        noMoreViewBuilder: (list, context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "共${list.length}条",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),

    );
  }

  void goDetailPage(String proNo) async {
    showLoading();
    var result = await RechargeRecordDao.orderDetail(proNo);
    dismissLoading();
    Map rechargeDetailMap = json.decode(result);
    var detailModel = new OrderDetailModel.fromJson(rechargeDetailMap);
    if(detailModel.rSPCOD == '00000'){

      WdNavigator.getInstance().onJumpTo(RouteStatus.rechargeDetail,args: {"detailModel": detailModel});

    }else {
      showToast(detailModel.rSPMSG);
    }
  }

}