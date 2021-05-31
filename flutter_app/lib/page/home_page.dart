
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/http/dao/home_dao.dart';
import 'package:flutterapp/model/query_meter_model.dart';
import 'package:flutterapp/model/supplier_model.dart';
import 'package:flutterapp/navigator/wd_navigator.dart';
import 'package:flutterapp/provider/supplier_provider.dart';
import 'package:flutterapp/provider/theme_provider.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/util/common_util.dart';
import 'package:flutterapp/util/toast.dart';
import 'package:flutterapp/widget/custom_drawer/drawer_user_controller.dart';
import 'package:flutterapp/widget/custom_drawer/home_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends WdState<HomePage> {

  Widget screenView;
  ThemeProvider _themeProvider;
  SupplierProvider _supplierProvider;
  String meterNo;

  @override
  void initState() {
    super.initState();
    _themeProvider = context.read<ThemeProvider>();
    _supplierProvider = context.read<SupplierProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ThemeProvider>(builder: (BuildContext context, ThemeProvider themeProvider, Widget child){
          return DrawerUserController(
            menuView: Image(
              image: AssetImage("images/img_home_left.png"),
              width: 18,
              height: 19,
            ),
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              print("点击位置 $drawerIndexdata ");
              //退出登录
              if(drawerIndexdata == DrawerIndex.SignOut){
                WdCache.getInstance().setString(CommonUtil.TOKEN, "");
                WdCache.getInstance().setString(CommonUtil.KEY, "");
                WdNavigator.getInstance().onJumpTo(RouteStatus.login);
              }//About
              else if(drawerIndexdata == DrawerIndex.About){
                WdNavigator.getInstance().onJumpTo(RouteStatus.about);
              }//DrawerIndex.DarkMode
              else if(drawerIndexdata == DrawerIndex.DarkMode){
                WdNavigator.getInstance().onJumpTo(RouteStatus.darkMode);
              }

            },
            color: themeProvider.isDark() ? WdColor.dark_bg : Colors.white,
            screenView: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(

                child:Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 300),
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
                                height: MediaQuery.of(context).size.width/750*590,
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
                                        child: Container(
                                          width: 18,
                                          height: 19,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: FlatButton(
                                          padding: const EdgeInsets.only( top: 50),
                                          child: Image(
                                            image: AssetImage("images/img_home_logo.png"),
                                            width: 68,
                                            height: 18,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 0,
                                        child: FlatButton(
                                          onPressed:() async {
                                            WdNavigator.getInstance().onJumpTo(RouteStatus.rechargeRecord);
                                          },
                                          padding: const EdgeInsets.only( top: 50),
                                          child: Image(
                                            image: AssetImage("images/img_home_right.png"),
                                            width: 18,
                                            height: 19,
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
                              top: 150,
                              child: Container(

                                constraints: BoxConstraints.expand(
                                    width: 120,
                                    height: 120
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: ThemeColors.colorSelectBlue, width: 2),
                                    borderRadius: BorderRadius.circular((5.0)),
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
                    Column(
                      children: [
                        Container(
                          child: Text(
                            "付款到",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 0),
                          constraints: BoxConstraints.expand(
                              width: 200,
                              height: 45
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                // 四个值 top right bottom left
                                  bottom: BorderSide(
                                    // 设置单侧边框的样式
                                      color: Colors.grey,
                                      width: 1,
                                      style: BorderStyle.solid))
                          ),
                          child: TextButton(
                              onPressed:() async {
                                WdNavigator.getInstance().onJumpTo(RouteStatus.supplier);
                              },
                              child: Consumer<SupplierProvider>(builder: (BuildContext context, SupplierProvider supplierProvider, Widget child){
                                return Text(
                                  supplierProvider.ELEN_NAME == null ? "请选中付款单位" : supplierProvider.ELEN_NAME ,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.left,
                                );
                              }

                                //padding: const EdgeInsets.only( top: 40),

                              )),
                        ), Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "表号",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 200,
                          height: 44,
                          child: TextField(

                            autofocus: true,
                            //textAlign: Center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            decoration: InputDecoration(
                              hintText: "请输入表号",
                              hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),//设置提示文字样式

                            ),
                            onChanged: (text){
                              meterNo = text;
                            },
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
                              queryMeter();
                            },
                            child: Text(
                              "下一步",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
    })
    );
  }

  //查询表
  void queryMeter() async {
    showLoading();
    var result = await HomeDao.queryMeter(_supplierProvider.ELEN_ID, meterNo);
    dismissLoading();
    Map queryMeterMap = json.decode(result);
    var queryMeter = new QueryMeterModel.fromJson(queryMeterMap);
    if(queryMeter.rSPCOD == '00000'){
      queryMeter.ENEL_ID = _supplierProvider.ELEN_ID;
     showToast("查询表成功");
     //传参
     WdNavigator.getInstance().onJumpTo(RouteStatus.billDetail,args: {"queryMeterModel": queryMeter});

    }else {
      showToast(queryMeter.rSPMSG);
    }
  }
}