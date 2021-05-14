
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextButton extends StatelessWidget {

  final String title;
  final Color color;
  final VoidCallback onPressed;

  const LoginTextButton( this.title, this.color,{ Key key,this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:onPressed,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 16.0,
        ),
      ),
    );
  }

}