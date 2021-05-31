import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';

/*
    * @description: 创建电话、短信、邮件服务
    */
class WdTelAndSmsService {
  /*
        * @description:  打电话
        * @param {type}
        * number 电话号码
        */
  void call(String number) => launch("tel:$number");
  /*
        * @description:  发短信
        * @param {type}
        * number 电话号码
        */
  void sendSms(String number) => launch("sms:$number");
  /*
        * @description:  发邮件
        * @param {type}
        * email 邮箱
        */
  void sendEmail(String email) => launch("mailto:$email");
}

class GetItClass {
  final locator = GetIt.instance;
  void setupLocator() {
    locator.registerSingleton(WdTelAndSmsService());
  }
}