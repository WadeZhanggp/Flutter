import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key,this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
  ),
);

class _LoginPageState extends State<LoginPage> {


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
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, top: 40),
                    child: Image(
                      image: AssetImage("images/img_phone.png"),
                      width: 16,
                      height: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 20,top: 60,right: 30),
                    child:  TextField(
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: "请输入登录密码",
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
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, top: 40),
                    child: Image(
                      image: AssetImage("images/img_passwd.png"),
                      width: 16,
                      height: 22,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 20,top: 60,right: 30),
                    child:  TextField(
                      autofocus: true,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: "请输入电话号码",
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
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 48, top: 60, right: 48),
              width: double.infinity,
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
                onPressed:(){
                  Navigator.pushNamed(context, "home_page");
                },
                child: Text(
                    "登录",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                color: Colors.transparent,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed:(){

                    },
                    padding: const EdgeInsets.only(left: 30, top: 40),
                    child: Text(
                      "注册",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  height: 30,
                  width: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    onPressed:(){

                    },
                    padding: const EdgeInsets.only(left: 30, top: 40,right: 50),
                    child: Text(
                      "忘记密码？",
                      style: TextStyle(
                        color: Colors.grey,
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
}
