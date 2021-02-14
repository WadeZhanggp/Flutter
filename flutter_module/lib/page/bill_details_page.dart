import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/dio/http_dio.dart';
import 'package:flutter_module/model/supplier_model.dart';
import 'package:flutter_module/utils/common_data.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';
import 'package:flutter_module/utils/theme_colors.dart';

class BillDetailsPage extends StatefulWidget {
  BillDetailsPage({Key key}) : super(key: key);

  @override
  _BillDetailsPage createState() => _BillDetailsPage(

  );
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

class _BillDetailsPage extends State<BillDetailsPage> {

  SupplierModel supplerModel;
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.expand(height: 200),
                child: Stack(
                  alignment:Alignment.center,
                  //overflow：此属性决定如何显示超出Stack显示空间的子组件；值为Overflow.clip时，超出部分会被剪裁（隐藏），值为Overflow.visible 时则不会。
                  overflow: Overflow.visible,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        //设置背景图片
                        constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.width/750*490,
                          width: MediaQuery.of(context).size.width,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/img_home_nav.png"),
                              fit:BoxFit.cover,
                            )
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: FlatButton(
                                    onPressed:() async {
                                      Navigator.of(context).pop();
                                    },
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Image(
                                      image: AssetImage("images/img_home_back.png"),
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FlatButton(
                                    padding: const EdgeInsets.only( top: 40,right: 50),
                                    child: Text(
                                      "缴费账户信息",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 100,
                        right: 20,
                        child: Container(

                          constraints: BoxConstraints.expand(
                              width: 120,
                              height: 120
                          ),
                          decoration: BoxDecoration(
                              //border: Border.all(color: ThemeColors.colorSelectBlue, width: 2),
                              borderRadius: BorderRadius.circular((60.0)),
                              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(5.0, 5.0), blurRadius: 10.0, spreadRadius: 2.0)],
                              color: Colors.white
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Image(
                                  image: AssetImage("images/img_home_electric.png"),
                                  width: 30,
                                  height: 50,
                                ),
                                padding: EdgeInsets.only(top: 15),
                              ),
                              Container(
                                child: Text(
                                  "电费",
                                  style: TextStyle(
                                    color: ThemeColors.colorSelectBlue,
                                    fontSize: 18,
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 10),
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return new Container(
                            constraints: BoxConstraints.expand(
                              //rwidth: 200,
                                height: 45
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 18),
                                    child: Text(
                                        "名称"
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 18),
                                    child: Text(
                                      "值",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        "请输入支付金额",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 200,
                      height: 44,
                      child: TextField(
                        controller: amountController,
                        autofocus: true,
                        //textAlign: Center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          hintText: "请输入缴费金额",
                          hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),//设置提示文字样式
                          border: _underlineInputBorder,
                          focusedBorder: _underlineInputBorder,
                          enabledBorder: _underlineInputBorder,
                          disabledBorder: _underlineInputBorder,
                          focusedErrorBorder: _underlineInputBorder,
                          errorBorder: _underlineInputBorder,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      width: 200,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage("images/img_button_bg.png"),
                            fit: BoxFit.fill
                        ),
                      ),
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed:() async {
                          await EasyLoading.show(
                            maskType: EasyLoadingMaskType.black,
                          );
                          //创建时间对象，获取当前时间
                          DateTime now = new DateTime.now();
                          String amount = amountController.text;
                          var token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);



                          HttpDio.getInstance().post(CommonData.appUrl, params: null).then((value) {
                            print("接口返回的数据是:${value}");
                            //Map loginMap = json.decode(value);
                            //var login = new LoginModel.fromJson(loginMap);
                            //bill_details_page
                            Navigator.pushNamed(context, "bill_details_page");
                          }).whenComplete(() {
                            print("异步任务处理完成");
                            EasyLoading.dismiss();
                          }).catchError((){
                            EasyLoading.dismiss();
                          });
                        },
                        child: Text(
                          "立即支付",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
