
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterapp/util/color.dart';

class HomeSwiper extends StatelessWidget {

  List<String> images = [
    "images/img_home_electricity.png",
    "images/img_home_gas.png",
    "images/img_home_water.png",
  ];

  List<String> titles = [
    "电费",
    "燃气",
    "水费",
  ];

  @override
  Widget build(BuildContext context) {
    return new Swiper(
      itemBuilder: (BuildContext context, int index) {

        return Stack(
          children: [
            Image(
              image: AssetImage(images[index]),
              width: 152,
              height: 152,
            ),
            Positioned(
              child: Container(
                child: Text(
                  titles[index],
                  style: TextStyle(
                    fontSize: 26,
                    color: ThemeColors.colorTheme,
                  ),
                  //textAlign: TextAlign.center,
                ),
                width: 52,
              ),
              top: 90,
              right: 50,
              left: 50,
            )
          ],
        );
      },



      //indicatorLayout: PageIndicatorLayout.COLOR,
      autoplay: false,
      itemCount: images.length,
      //pagination: SwiperPagination(),
      viewportFraction: 0.5,
      scale: 0.5,

    );

  }
}