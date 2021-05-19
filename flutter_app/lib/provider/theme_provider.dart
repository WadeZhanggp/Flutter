import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterapp/db/wd_cache.dart';
import 'package:flutterapp/util/color.dart';
import 'package:flutterapp/util/wd_constants.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode;
  var _platformBrightness = SchedulerBinding.instance.window.platformBrightness;

  ///系统Dark Mode发生变化
  void darModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance.window.platformBrightness) {
      _platformBrightness = SchedulerBinding.instance.window.platformBrightness;
      notifyListeners();
    }
  }

  ///判断是否是Dark Mode
  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      //获取系统的Dark Mode
      return SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ///获取主题模式
  ThemeMode getThemeMode() {

    String theme = WdCache.getInstance().get(WdConstants.theme);
    switch (theme) {
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode;
  }

  ///设置主题
  void setTheme(ThemeMode themeMode) {
    WdCache.getInstance().setString(WdConstants.theme, themeMode.value);
    notifyListeners();
  }

  ///获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        errorColor: isDarkMode ? WdColor.dark_red : WdColor.red,
        primaryColor: isDarkMode ? WdColor.dark_bg : white,
        accentColor: isDarkMode ? primary[50] : white,
        //Tab指示器的颜色
        indicatorColor: isDarkMode ? primary[50] : white,
        //页面背景色
        scaffoldBackgroundColor: isDarkMode ? WdColor.dark_bg : white);
    return themeData;
  }
}
