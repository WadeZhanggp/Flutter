import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/supplier_model.dart';
import 'package:flutterapp/provider/supplier_provider.dart';
import 'package:flutterapp/provider/theme_provider.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/util/toast.dart';
import 'package:flutterapp/widget/wd_appbar.dart';
import 'package:provider/provider.dart';


class SupplierPage extends StatefulWidget {
  SupplierPage({Key key}) : super(key: key);



  @override
  _SupplierPage createState() => _SupplierPage(

  );
}


class _SupplierPage extends State<SupplierPage> {

  final meterNoController = TextEditingController();
  final List<SupplierModel> supplierList = <SupplierModel>[
    SupplierModel("Y2017021500003","海兴6号北面宿舍楼"),
    SupplierModel("Y2017022800005", "海兴3号/6号南门宿舍"),
    SupplierModel("Y2018020200004", "宁波恒利达科技"),
  ];
  SupplierProvider _supplierProvider;

  @override
  void initState() {
    super.initState();
    _supplierProvider = context.read<SupplierProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WdAppBar(
            barHeight: 88,
            backgroundColor: ThemeColors.colorTheme,
            leadingWidget:  Container(
              child: Row(
                children: [
                  Image(
                    image: AssetImage("images/img_back_white.png"),
                    width: 20,
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Text(
                      "付款到",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            onPressedLeft: () async {
              print('点击左');
              Navigator.of(context).pop();
            }
        ),
        body:ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: supplierList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              constraints: BoxConstraints.expand(
                  //rwidth: 200,
                  height: 60
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
              child: FlatButton(
                onPressed:() async {
                  //带参数返回
                  Navigator.pop(context, supplierList[index]);
                  _supplierProvider.setSupplier(supplierList[index]);

                },
                //padding: const EdgeInsets.only( top: 40),
                child: Text(
                    supplierList[index].ELEN_NAME
                ),
              ),
            );
          },
        ),
    );
  }
}


