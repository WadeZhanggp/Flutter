import 'package:flutter/material.dart';
import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/page/home_page.dart';
import 'package:flutterapp/page/login_page.dart';
import 'package:flutterapp/page/register_page.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/util/toast.dart';

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
          return MaterialApp(
            home: widget,
            theme: ThemeData(primarySwatch: white),
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
    //实现路由跳转逻辑
    WdNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map args}) {
          _routeStatus = routeStatus;
          if (routeStatus == RouteStatus.detail) {

          }
          notifyListeners();
        }));
    //设置网络错误拦截器
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];

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

    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(HomePage());
    }  else if (routeStatus == RouteStatus.register) {
      page = pageWrap(RegisterPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
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
                showWarnToast("请先登录");
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
    if (_routeStatus != RouteStatus.register && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  bool hasLogin = false;
  //bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {}

}

class AppRoutePath {
  final String location;

  AppRoutePath.home() : location = "/";

  AppRoutePath.detail() : location = "/detail";
}

