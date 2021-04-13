/// RSPCOD : "00000"
/// AUTH : {"SOURCE":"5","REQUEST_TIME":"2021-02-15 15:55:10.347157"}
/// RSPMSG : "下单成功!"
/// DATA : {"POWER_AMT":"10.00","FEE_AMT":"0","PRDORDNO":"D021021500141187","PAY_AMT":"10.00"}

class CreateOrderModel {
  String rSPCOD;
  AUTH aUTH;
  String rSPMSG;
  DATA dATA;

  CreateOrderModel({this.rSPCOD, this.aUTH, this.rSPMSG, this.dATA});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    rSPCOD = json['RSPCOD'];
    aUTH = json['AUTH'] != null ? new AUTH.fromJson(json['AUTH']) : null;
    rSPMSG = json['RSPMSG'];
    dATA = json['DATA'] != null ? new DATA.fromJson(json['DATA']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RSPCOD'] = this.rSPCOD;
    if (this.aUTH != null) {
      data['AUTH'] = this.aUTH.toJson();
    }
    data['RSPMSG'] = this.rSPMSG;
    if (this.dATA != null) {
      data['DATA'] = this.dATA.toJson();
    }
    return data;
  }
}

class AUTH {
  String sOURCE;
  String rEQUESTTIME;

  AUTH({this.sOURCE, this.rEQUESTTIME});

  AUTH.fromJson(Map<String, dynamic> json) {
    sOURCE = json['SOURCE'];
    rEQUESTTIME = json['REQUEST_TIME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SOURCE'] = this.sOURCE;
    data['REQUEST_TIME'] = this.rEQUESTTIME;
    return data;
  }
}

class DATA {
  String pOWERAMT;
  String fEEAMT;
  String pRDORDNO;
  String pAYAMT;

  DATA({this.pOWERAMT, this.fEEAMT, this.pRDORDNO, this.pAYAMT});

  DATA.fromJson(Map<String, dynamic> json) {
    pOWERAMT = json['POWER_AMT'];
    fEEAMT = json['FEE_AMT'];
    pRDORDNO = json['PRDORDNO'];
    pAYAMT = json['PAY_AMT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['POWER_AMT'] = this.pOWERAMT;
    data['FEE_AMT'] = this.fEEAMT;
    data['PRDORDNO'] = this.pRDORDNO;
    data['PAY_AMT'] = this.pAYAMT;
    return data;
  }
}