import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/page/bill_details_page.dart';
import 'package:flutter_module/page/home_page.dart';
import 'package:flutter_module/page/login_page.dart';
import 'package:flutter_module/page/recharge_detail_page.dart';
import 'package:flutter_module/page/recharge_record_page.dart';
import 'package:flutter_module/page/supplier_page.dart';
import 'package:flutter_module/utils/common_util.dart';
import 'package:flutter_module/utils/sharepreferences_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


//void main() => runApp(
//    MyApp(),
//);
void main() {
  runApp(MyApp());
  configLoading();
}

var token;

Future<void> configLoading() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

    token = await SharePreferencesUtils.readFromLocalMap(CommonUtil.TOKEN);
    print("token " + token);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        headerBuilder: () => WaterDropHeader(),        // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
        footerBuilder:  () => ClassicFooter(),        // 配置默认底部指示器
        headerTriggerDistance: 80.0,        // 头部触发刷新的越界距离
        springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // 自定义回弹动画,三个属性值意义请查询flutter api
        maxOverScrollExtent :100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
        maxUnderScrollExtent:0, // 底部最大可以拖动的范围
        enableScrollWhenRefreshCompleted: true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
        enableLoadingWhenFailed : true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
        hideFooterWhenNotFull: false, // Viewport不满一屏时,禁用上拉加载更多功能
        enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
        child: MaterialApp(
          title: 'Opay',
          debugShowCheckedModeBanner: false,//去除debug水印
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: (
              token.toString() == null ? HomePage() : LoginPage()
          ),
          routes: {
            "home_page":(context)=> HomePage(),
            "recharge_record_page":(context) => RechargeRecordPage(),
            "supplier_page":(context) => SupplierPage(),
            "bill_details_page":(context) => BillDetailsPage(),
            "recharge_detail_page":(context) => RechargeDetailPage(),
          },
          builder: EasyLoading.init(),
        )
    );
  }
}


