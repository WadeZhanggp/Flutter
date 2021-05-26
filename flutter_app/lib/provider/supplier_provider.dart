import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/supplier_model.dart';

class SupplierProvider extends ChangeNotifier {

  String ELEN_ID;//服务商id
  String ELEN_NAME;//服务商名称

  ///设置
  void setSupplier(SupplierModel supplierModel) {

    ELEN_ID = supplierModel.ELEN_ID;
    ELEN_NAME = supplierModel.ELEN_NAME;
    //通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  ///获取
  SupplierModel getSupplierModel() {
    SupplierModel supplierModel = SupplierModel(this.ELEN_ID, this.ELEN_NAME);
    return supplierModel;
  }

}