

import 'package:flutterapp/http_net/dao/login_dao.dart';
import 'package:hi_net/request/hi_base_request.dart';

abstract class BaseRequest extends HiBaseRequest {
  @override
  String url() {
    if (needLogin()) {
      //给需要登录的接口携带登录令牌

    }
    return super.url();
  }

  Map<String, dynamic> header = {

  };
}
