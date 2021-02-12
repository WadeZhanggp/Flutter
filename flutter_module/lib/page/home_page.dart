import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/utils/theme_colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(

  );
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //层叠布局
        child: Stack(
          alignment:Alignment.center,
          children: [
            Container(
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
                        child: FlatButton(
                          onPressed:() async {

                          },
                          padding: const EdgeInsets.only(top: 40),
                          child: Image(
                            image: AssetImage("images/img_home_left.png"),
                            width: 18,
                            height: 19,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FlatButton(
                          padding: const EdgeInsets.only( top: 40),
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

                          },
                          padding: const EdgeInsets.only( top: 40),
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
            Positioned(
                child: Column(
                  
                )
            )

          ],
        )
      ),
    );
  }
}
