
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonBigButton extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;

  const CommonBigButton(this.title,{Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: TextButton(
        onPressed:onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
  
}