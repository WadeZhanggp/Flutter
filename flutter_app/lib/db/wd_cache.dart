import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class WdCache {
  SharedPreferences prefs;

  WdCache._() {
    init();
  }

  static WdCache _instance;

  WdCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  ///预初始化，防止在使用get时，prefs还未完成初始化
  static Future<WdCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = WdCache._pre(prefs);
      //getInstance().setString(, value)
    }
    return _instance;
  }

  static WdCache getInstance() {
    if (_instance == null) {
      _instance = WdCache._();
    }
    return _instance;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    prefs.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  T get<T>(String key) {
    return prefs?.get(key) ?? null;
  }
}
