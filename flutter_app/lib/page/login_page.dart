
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/core/wd_state.dart';
import 'package:flutterapp/db/wd_cache.dart';
//import 'package:flutterapp/http_net/dao/login_dao.dart';
import 'package:flutterapp/http/dao/login_dao.dart';
import 'package:flutterapp/model/login_model.dart';
import 'package:flutterapp/navigator/wd_navigator.dart';
import 'package:flutterapp/util/common_util.dart';
import 'package:flutterapp/util/toast.dart';
import 'package:flutterapp/util/view_util.dart';
import 'package:flutterapp/widget/common_big_button.dart';
import 'package:flutterapp/widget/login_input.dart';
import 'package:flutterapp/widget/login_text_button.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
  
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);


class _LoginPageState extends WdState<LoginPage> with WidgetsBindingObserver{

  bool loginEnable = false;
  String userName;
  String password;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  ///监听应用生命周期变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(':didChangeAppLifecycleState:$state');
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
      //fix Android压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        //changeStatusBar();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //color: Colors.red,
              child: Container(
                alignment: const Alignment(0.0, 0.0),
                margin: const EdgeInsets.only(top: 100),
                child: Image(
                  image: AssetImage("images/img_opay_title.png"),
                  width: 80,
                  height: 162,
                ),
              ),
            ),
            LoginInput(
              "请输入用户名",
              image: AssetImage("images/img_phone.png"),
              onChanged: (text) {
                userName = text;
              },
            ),
            LoginInput(
              "请输入密码",
              image: AssetImage("images/img_passwd.png"),
              onChanged: (text) {
                password = text;
              },
            ),
            CommonBigButton(
              "登录",
              onPressed: login,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: LoginTextButton(
                    "注册",
                    Colors.blue,
                    onPressed: () async {
                      WdNavigator.getInstance().onJumpTo(RouteStatus.register);
                    },
                  ),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  flex: 1,
                  child: LoginTextButton(
                      "忘记密码",
                      Colors.grey,
                      onPressed: () async {
                        WdNavigator.getInstance().onJumpTo(RouteStatus.forget);
                      }
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //登录
  void login() async {

    //var result = await LoginDao.login(userName, password);
    showLoading();
    var result = await LoginDao.login(userName, password);
    dismissLoading();
    Map loginMap = json.decode(result);
    var login = new LoginModel.fromJson(loginMap);
    if(login.rSPCOD == '00000'){
      showToast("登录成功");
      WdCache.getInstance().setString(CommonUtil.TOKEN, login.dATA.sESSIONID);
      WdCache.getInstance().setString(CommonUtil.KEY, login.dATA.kEY);
      WdNavigator.getInstance().onJumpTo(RouteStatus.home);

    }else {
      if(login.rSPCOD == '00000'){
        showToast("验证码发送成功");
      }else {
        showToast(login.rSPMSG);
      }
    }
    
  }


}