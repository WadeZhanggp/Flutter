import 'package:flutter/material.dart';

Widget picAndTextButton(String imgpath,String text) {
  return Container(
    width: 200,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
          image: AssetImage(imgpath),
          fit: BoxFit.fill
      ),
    ),
    alignment: Alignment.center,
    child: FlatButton(
      //onPressed: _theDayBefor,
      child: Text(text),
      color: Colors.transparent,
    ),
  );
}