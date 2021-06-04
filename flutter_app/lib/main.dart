import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/model/order_detail_model.dart';
import 'package:flutterapp/page/about_page.dart';
import 'package:flutterapp/page/bill_details_page.dart';
import 'package:flutterapp/page/dark_mode_page.dart';
import 'package:flutterapp/page/forget_passwd.dart';
import 'package:flutterapp/page/home_page.dart';
import 'package:flutterapp/page/login_page.dart';
import 'package:flutterapp/page/recharge_detail_page.dart';
import 'package:flutterapp/page/recharge_record_page.dart';
import 'package:flutterapp/page/register_page.dart';
import 'package:flutterapp/page/supplier_page.dart';
import 'package:flutterapp/page/web_view.dart';
import 'package:flutterapp/provider/supplier_provider.dart';
import 'package:flutterapp/provider/theme_provider.dart';
import 'package:flutterapp/provider/wd_provider.dart';
import 'package:provider/provider.dart';

import 'http/dao/login_dao.dart';
import 'model/query_meter_model.dart';
import 'navigator/wd_navigator.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  AppRouteDelegate _routeDelegate = AppRouteDelegate();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WdCache>(
        //进行初始化
        future: WdCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<WdCache> snapshot){


          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routeDelegate)
              : Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
          return MultiProvider(
              providers: topProviders,
              child: Consumer<ThemeProvider>(builder: (BuildContext context, ThemeProvider themeProvider, Widget child){
                return MaterialApp(
                    theme: themeProvider.getTheme(),
                    home: widget,
                    darkTheme: themeProvider.getTheme(isDarkMode: true),
                    themeMode: themeProvider.getThemeMode(),
                    builder: EasyLoading.init()
                );
              },),
          );
        }
    );
  }
}

class AppRouteDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath>{
  final GlobalKey<NavigatorState> navigatorKey;





  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  AppRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //String token = LoginDao.getToken();

    //实现路由跳转逻辑
    WdNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.billDetail) {
            this.queryMeter = args['queryMeterModel'];
          }else if (routeStatus == RouteStatus.rechargeDetail) {
            this.orderDetailModel = args['detailModel'];
          }else if (routeStatus == RouteStatus.webView) {
            this.webUrl = args['webUrl'];
          }

          notifyListeners();
        }));

//    if(!hasLogin){
//      //拉起登录
//      WdNavigator.getInstance().onJumpTo(RouteStatus.login);
//    }


  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  QueryMeterModel queryMeter;
  OrderDetailModel orderDetailModel;
  String webUrl;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;


    //print("token" + LoginDao.getToken() );

    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(HomePage());
    }  else if (routeStatus == RouteStatus.register) {
      page = pageWrap(RegisterPage());
    } else if (routeStatus == RouteStatus.login) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(LoginPage());
    }else if (routeStatus == RouteStatus.forget) {
      page = pageWrap(ForgetPasswdPage());
    }else if (routeStatus == RouteStatus.login) {
      pages.clear();
      page = pageWrap(LoginPage());
    }else if (routeStatus == RouteStatus.about) {
      page = pageWrap(AboutPage());
    }else if (routeStatus == RouteStatus.rechargeRecord) {
      page = pageWrap(RechargeRecordPage());
    }else if (routeStatus == RouteStatus.rechargeDetail) {
      page = pageWrap(RechargeDetailPage(orderDetailModel));
    }else if (routeStatus == RouteStatus.supplier) {
      page = pageWrap(SupplierPage());
    }else if (routeStatus == RouteStatus.billDetail) {
      page = pageWrap(BillDetailsPage(queryMeter));
    }else if (routeStatus == RouteStatus.darkMode) {
      page = pageWrap(DarkModePage());
    }else if (routeStatus == RouteStatus.webView) {
      page = pageWrap(WebViewPage(webUrl));
    }


    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    WdNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async => !await navigatorKey.currentState.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                EasyLoading.showToast("请先登录");
                return false;
              }
            }
          }
          //执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //通知路由发生变化
          WdNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }


  RouteStatus get routeStatus {

    //print("token" + LoginDao.getToken() );
    if (_routeStatus != RouteStatus.forget && _routeStatus != RouteStatus.register && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    }
    else {
      return _routeStatus;
    }
  }


  bool get hasLogin => LoginDao.getToken() !=  null;
//
  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {}

}

class AppRoutePath {
  final String location;

  AppRoutePath.home() : location = "/";

  AppRoutePath.detail() : location = "/detail";
}


