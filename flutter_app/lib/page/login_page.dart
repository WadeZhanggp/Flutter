
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/http/dao/login_dao.dart';
import 'package:flutterapp/util/toast.dart';
import 'package:flutterapp/widget/common_big_button.dart';
import 'package:flutterapp/widget/login_input.dart';

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


class _LoginPageState extends State<LoginPage> {

  bool loginEnable = false;
  String userName;
  String password;

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
              image: AssetImage("images/img_passwd.png"),
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
              onPressed: send,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed:() async {
                      Navigator.pushNamed(context, "register_page");
                    },
                    padding: const EdgeInsets.only(left: 30, top: 40,right: 30),
                    child: Text(
                      "注册",
                      //
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void send() async {
    showWarnToast("登录");
    var result = await LoginDao.login(userName, password);
    print(result);
  }
}