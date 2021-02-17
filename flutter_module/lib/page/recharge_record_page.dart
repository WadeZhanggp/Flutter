import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/dio/http_dio.dart';
import 'package:flutter_module/model/order_detail_model.dart';
import 'package:flutter_module/model/order_list_model.dart';
import 'package:flutter_module/model/recharge_record_model.dart';
import 'package:flutter_module/utils/common_data.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';
import 'package:flutter_module/utils/theme_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RechargeRecordPage extends StatefulWidget {
  RechargeRecordPage({Key key}) : super(key: key);

  @override
  _RechargeRecordPage createState() => _RechargeRecordPage(

  );
}



class _RechargeRecordPage extends State<RechargeRecordPage> {

  final meterNoController = TextEditingController();

  //每页显示数量
  static const int PAGE_SIZE = 7;
  //当前为第几页
  int page = 1;
  //是否加载过数据
  bool loaded;
  //是否允许上拉
  bool _enablePullUp = true;
  //listview数据源
  List<TRANRECORD> orderItems = [];
  //刷新加载控制器
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("充值记录"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _buildListData(),
              ),
            ],
          ),
        )
    );
  }

  ///构建body部分widget
  _buildListData() {

    //给listview增加父节点SmartRefresher
    return SmartRefresher(
      ///可在此通过header:和footer:指定个性效果
      //允许下拉
      enablePullDown: true,
      //允许上拉加载
      enablePullUp: _enablePullUp,
      //控制器
      controller: _refreshController,
      //刷新回调方法
      onRefresh: _onRefresh,
      //加载下一页回调
      onLoading: _onLoading,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          //添加点击手势
          return GestureDetector(
            child: Container(
              child: Container(
                height: 85,
                constraints: BoxConstraints.expand(
                    width: MediaQuery.of(context).size.width,
                    height: 85
                ),
                decoration: BoxDecoration(
                    border: Border(
                      // 四个值 top right bottom left
                        bottom: BorderSide(
                          // 设置单侧边框的样式
                            color: Colors.grey,
                            width: 0.5,
                            style: BorderStyle.solid))
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Image(
                            image: AssetImage("images/img_payment.png"),
                            width: 38,
                            height: 38,
                          ),
                        )
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Payment",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 6),
                                child: Text(
                                  orderItems[index].tRANDATE,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 16),
                              child: Text(
                                orderItems[index].tRANAMT,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text(
                                getStatusWithCode(orderItems[index].oRDSTATUS),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey
                                ),
                              ),
                            ),

                          ],
                        )
                    )

                  ],
                ),
              ),
            ),
            onTap: (){
              if(orderItems[index].oRDSTATUS == "01"){
                goDetailPage(orderItems[index].pRDORDNO);
              }

            },
          );
        },
        itemCount: orderItems.length,
      ),
    );
  }

  void _onRefresh() async {
    _loadData(true);
  }

  void _onLoading() async {
    _loadData(false);
  }

  void _initData() async {
    _loadData(true);
  }
  _loadData(final bool onRefresh) async {
    int pageNum;
    if(onRefresh){
      pageNum = 1;
    }else{
      pageNum = page+1;
    }
    Map<String, dynamic> query = new Map();
    query['pageNum'] = pageNum;
    query['pageSize'] = PAGE_SIZE;

    //创建时间对象，获取当前时间
    DateTime now = new DateTime.now();
    var token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);

    Map<String, String> authParam = {
      "SESSION_ID": token,
      "SOURCE": "5",
      "REQUEST_TIME": now.toString(),
      "LANG": 'zh',
    };

    Map<String, String> dataParam = {
      //"MONTH" : "202102",
      "PAGENUM": pageNum.toString()
    };

    //验签加密
    String signature = await CommonUtil.signatureString(authParam, dataParam);

    Map<String, String> tailParam = {
      "SIGN_TYPE":"1",
      "SIGNATURE":signature
    };

    Map<String, dynamic> requestParam = {
      "TAIL": tailParam,
      "auth": authParam,
      "data": dataParam,
      "tran": "HOrderRecord",
    };

    HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) async {
      print("接口返回的数据是:${value}");
      Map recharegRecordMap = json.decode(value);
      RechargeRecordModel recordModel = RechargeRecordModel.fromJson(recharegRecordMap);
      if(recordModel.rSPCOD == '00000'){
        var list = recharegRecordMap['DATA']["TRAN_RECORD"] as List;

        List<TRANRECORD> tranList = list.map((i) => TRANRECORD.fromJson(i)).toList();
        //
        if(onRefresh){
          orderItems.clear();
        }

        if(tranList.length >= 7){
          setState(() {
            orderItems.addAll(tranList);
            _refreshController.refreshCompleted();

            _enablePullUp = true;
          });
        }else {
          setState(() {
            orderItems.addAll(tranList);
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
            _enablePullUp = false;
          });

        }



      }



    }).whenComplete(() {
      print("异步任务处理完成");
      EasyLoading.dismiss();
    }).catchError((){
      EasyLoading.dismiss();
    });

  }

  String getStatusWithCode(String code){
    if(code == "00"){
      return "未支付";
    }else if(code == "01") {
      return "支付成功";
    }else if(code == "02") {
      return "支付中";
    }else if(code == "11") {
      return "支付失败";
    }
  }

  goDetailPage(String proNo) async {
    await EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    //创建时间对象，获取当前时间
    DateTime now = new DateTime.now();
    var token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);

    Map<String, String> authParam = {
      "SESSION_ID": token,
      "SOURCE": "5",
      "REQUEST_TIME": now.toString(),
      "LANG": 'zh',
    };

    Map<String, String> dataParam = {
      "PRDORDNO":proNo
    };

    //验签加密
    String signature = await CommonUtil.signatureString(authParam, dataParam);

    Map<String, String> tailParam = {
      "SIGN_TYPE":"1",
      "SIGNATURE":signature
    };

    Map<String, dynamic> requestParam = {
      "TAIL": tailParam,
      "auth": authParam,
      "data": dataParam,
      //
      "tran": "HOrderDetail",
    };

    HttpDio.getInstance().post(CommonData.appUrl, params: requestParam).then((value) async {
      print("接口返回的数据是:${value}");
      Map orderDetailMap = json.decode(value);
      OrderDetailModel recordModel = OrderDetailModel.fromJson(orderDetailMap);
      if(recordModel.rSPCOD == '00000'){
        Navigator.pushNamed(context, "recharge_detail_page",arguments: recordModel);
      }

    }).whenComplete(() {
      print("异步任务处理完成");
      EasyLoading.dismiss();
    }).catchError((){
      EasyLoading.dismiss();
    });

  }
}
