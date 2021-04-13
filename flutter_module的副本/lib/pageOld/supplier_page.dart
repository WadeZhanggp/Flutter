import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/model/supplier_model.dart';
import 'package:flutter_module/utils/theme_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("服务商"),
          backgroundColor: ThemeColors.colorTheme,
        ),
        body:ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: supplierList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              constraints: BoxConstraints.expand(
                  //rwidth: 200,
                  height: 45
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
                  //Navigator.pop(context);
                  //EasyLoading.showToast("点击"+supplierList[index].ELEN_NAME);
                  //带参数返回
                  Navigator.pop(context, supplierList[index]);
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


