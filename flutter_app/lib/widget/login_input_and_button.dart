
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginInputButton extends StatefulWidget {

  final String hint;
  final String rightButtonTitle;
  final AssetImage image;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool> focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType keyboardType;

  final VoidCallback onRightPressed;

  const LoginInputButton(
      this.hint,

      {Key key,this.rightButtonTitle, this.image, this.onChanged, this.focusChanged, this.keyboardType, this.lineStretch = false, this.obscureText = false, this.onRightPressed}
      ) : super(key: key);


  @override
  _LoginInputButtonState createState() => _LoginInputButtonState();

}

UnderlineInputBorder _underlineInputBorder = UnderlineInputBorder(
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);


class _LoginInputButtonState extends State<LoginInputButton>{

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
            height: 20,
            margin: const EdgeInsets.only(left: 20,top: 60,right: 30),
            child:  Column(
              children: [
                TextField(
                  //focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  autofocus: !widget.obscureText,
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
                TextButton(
                    onPressed:widget.onRightPressed ,
                    child: Text(
                      widget.rightButtonTitle
                    )
                )
              ],
            ),
          ),
        )
      ]
    );
  }

}