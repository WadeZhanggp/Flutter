
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {

  final String hint;
  final AssetImage image;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType keyboardType;


  const LoginInput(
      this.hint,

      {Key key, this.image, this.onChanged, this.focusChanged, this.keyboardType, this.lineStretch = false, this.obscureText = false}
      ) : super(key: key);


  @override
  _LoginInputState createState() => _LoginInputState();

}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

UnderlineInputBorder _bluelineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.blue,
  ),
);


class _LoginInputState extends State<LoginInput>{

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //是否获取光标的监听
//    _focusNode.addListener(() {
//      print("Has focus: ${_focusNode.hasFocus}");
//      if (widget.focusChanged != null) {
//        widget.focusChanged(_focusNode.hasFocus);
//      }
//    });
  }

//  @override
//  void dispose() {
//    _focusNode.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Container(
            padding: const EdgeInsets.only(left: 30, top: 40),
            child: Image(
              image: widget.image,
              width: 16,
              height: 22,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 30,
            margin: const EdgeInsets.only(left: 20,top: 60,right: 30),
            child:  TextField(
              //focusNode: _focusNode,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              autofocus: !widget.obscureText,
              cursorColor: Colors.blue,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
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
      ]
    );
  }

}