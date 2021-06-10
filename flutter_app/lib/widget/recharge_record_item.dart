
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/util/toast.dart';

class RechargeRecordItem extends StatelessWidget {

  final String tRANDATE;
  final String tRANAMT;
  final String oRDSTATUS;
  final VoidCallback onTap;

  const RechargeRecordItem(this.tRANDATE,this.tRANAMT,this.oRDSTATUS,{Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 14),
                          child: Text(
                            tRANDATE,
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
                          tRANAMT,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 14),
                        child: Text(
                          getStatusWithCode(oRDSTATUS),
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
      onTap: onTap,
    );
  }

  String getStatusWithCode(String code){
    if(code == "00"){
      return "未支付";
    }else if(code == "01") {
      return "支付成功";
    }else if(code == "02") {
      return "支付中";
    }else if(code == "11") {
      return "订单已关闭";
    }else if(code == "22") {
      return "支付中";
    }
    else {
      return "";
    }
  }

}