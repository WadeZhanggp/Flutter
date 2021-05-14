import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WdAppBar extends StatefulWidget implements PreferredSizeWidget {

  final double barHeight;
  final Color backgroundColor;
  final String backgroundImageName;
  final Widget leadingWidget;
  final Widget trailingWidget;
  final Widget centerWidget;
  final Brightness brightness;
  final double elevation;
  final VoidCallback onPressedLeft;
  final VoidCallback onPressedRight;

  WdAppBar({Key key,this.barHeight = 88,this.backgroundColor = Colors.white,this.backgroundImageName,this.leadingWidget,this.trailingWidget,@required this.centerWidget,this.brightness,this.elevation = 0, this.onPressedLeft, this.onPressedRight}):super(key: key);

  @override
  _WdAppBarState createState() => _WdAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(barHeight);

}

class _WdAppBarState extends State<WdAppBar> {

  @override
  Widget build(BuildContext context) {

    final SystemUiOverlayStyle overlayStyle = widget.brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(//套AnnotatedRegion是为了增加状态栏控制
      value: overlayStyle,
      child: Material(//套Material是为了增加elevation
        elevation: widget.elevation,
        child: Container(
          height: widget.barHeight,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              image: widget.backgroundImageName!=null ?  DecorationImage(
                  image: AssetImage(widget.backgroundImageName),
                  fit: BoxFit.fill
              ) : null
          ),
          child: SafeArea(
            child: Stack(
                alignment: Alignment.center,
                children: [
                  ///左边
                  Positioned(
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: TextButton(
                        child: widget.leadingWidget,
                        onPressed: widget.onPressedLeft,
                      ),
                    ),
                  ),
                  ///中间
                  Positioned(
                    top: 10,
                    child: Container(
                      child: widget.centerWidget,
                    ),
                  ),
                  ///右边
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(right: 15),
                      child: TextButton(
                        child: widget.trailingWidget,
                        onPressed: widget.onPressedRight,
                      ),
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}
