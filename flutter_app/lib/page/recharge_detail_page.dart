
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flutterapp/model/order_detail_model.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/widget/wd_appbar.dart';

class RechargeDetailPage extends StatefulWidget{

  //传参赋值
  final OrderDetailModel orderDetailModel;
  const RechargeDetailPage(this.orderDetailModel);



  @override
  _RechargeDetailPageState createState() => _RechargeDetailPageState();

}

class _RechargeDetailPageState extends WdState<RechargeDetailPage> {

  String stateImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String status = widget.orderDetailModel.dATA.oRDSTATUS;
    print("当前状态"+status);
    if(status == "11"){
      stateImage = "images/img_detail_status_failed.png";
    }else if(status == "01"){
      stateImage = "images/img_pay_success.png";
    }else if(status == "22" || status == "02"){
      stateImage = "images/img_detail_status_paying.png";
    }else {
      stateImage = "images/img_detail_status_failed.png";
    }
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
            "订单详情",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(this.stateImage),
                  height: 73,
                  width: 73,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "订单时间："+widget.orderDetailModel.dATA.tRANDATE + " " + widget.orderDetailModel.dATA.tRANTIME,
                  style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: Colors.grey,
              ),

              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 10,left: 20),
                child: Text(
                  "支付金额",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "RMB " + widget.orderDetailModel.dATA.tRANAMT,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.green
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(top: 10,left: 20),
                child: Text(
                  widget.orderDetailModel.dATA.tOKEN != null ?"Token" : "",
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  widget.orderDetailModel.dATA.tOKEN != null ? widget.orderDetailModel.dATA.tOKEN : "",
                  style: TextStyle(
                      fontSize: 24,
                      color: ThemeColors.colorTheme
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }



}