class OrderDetailModel {
  String rSPCOD;
  AUTH aUTH;
  String rSPMSG;
  DATA dATA;

  // 0-未支付；
  // 01-成功；
  // 02-支付处理中；
  // 20-第三方完成；
  // 22-第三方支付中；
  // 11-订单已关闭；

  OrderDetailModel({this.rSPCOD, this.aUTH, this.rSPMSG, this.dATA});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  String tOTALREWARD;
  String rEWARD;
  String fEEAMT;
  String pRDORDNO;
  String cUSTOMERNAME;
  String cARDSTA;
  String tRANAMT;
  String tRANTIME;
  String cUSTOMERID;
  String pRDORDTYPENAME;
  int gOODTYPENO;
  String tRANDATE;
  String dETAILIST;
  String mETERNO;
  String cCY;
  String gOODTYPE;
  String pOWERAMT;
  String iSAGENTFIRST;
  String oRDSTATUS;
  String aGENTLEVEL;
  String iSFIRST;
  String uNILITYNAME;
  int pRDORDTYPE;
  String tOKEN;
  String bIZTYPE;

  DATA(
      {this.tOTALREWARD,
        this.rEWARD,
        this.fEEAMT,
        this.pRDORDNO,
        this.cUSTOMERNAME,
        this.cARDSTA,
        this.tRANAMT,
        this.tRANTIME,
        this.cUSTOMERID,
        this.pRDORDTYPENAME,
        this.gOODTYPENO,
        this.tRANDATE,
        this.dETAILIST,
        this.mETERNO,
        this.cCY,
        this.gOODTYPE,
        this.pOWERAMT,
        this.iSAGENTFIRST,
        this.oRDSTATUS,
        this.aGENTLEVEL,
        this.iSFIRST,
        this.uNILITYNAME,
        this.pRDORDTYPE,
        this.tOKEN,
        this.bIZTYPE});

  DATA.fromJson(Map<String, dynamic> json) {
    tOTALREWARD = json['TOTAL_REWARD'];
    rEWARD = json['REWARD'];
    fEEAMT = json['FEE_AMT'];
    pRDORDNO = json['PRDORDNO'];
    cUSTOMERNAME = json['CUSTOMER_NAME'];
    cARDSTA = json['CARD_STA'];
    tRANAMT = json['TRAN_AMT'];
    tRANTIME = json['TRAN_TIME'];
    cUSTOMERID = json['CUSTOMER_ID'];
    pRDORDTYPENAME = json['PRDORDTYPENAME'];
    gOODTYPENO = json['GOOD_TYPENO'];
    tRANDATE = json['TRAN_DATE'];
    dETAILIST = json['DETAILIST'];
    mETERNO = json['METER_NO'];
    cCY = json['CCY'];
    gOODTYPE = json['GOOD_TYPE'];
    pOWERAMT = json['POWER_AMT'];
    iSAGENTFIRST = json['ISAGENTFIRST'];
    oRDSTATUS = json['ORDSTATUS'];
    aGENTLEVEL = json['AGENTLEVEL'];
    iSFIRST = json['ISFIRST'];
    uNILITYNAME = json['UNILITY_NAME'];
    pRDORDTYPE = json['PRDORDTYPE'];
    tOKEN = json['TOKEN'];
    bIZTYPE = json['BIZTYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOTAL_REWARD'] = this.tOTALREWARD;
    data['REWARD'] = this.rEWARD;
    data['FEE_AMT'] = this.fEEAMT;
    data['PRDORDNO'] = this.pRDORDNO;
    data['CUSTOMER_NAME'] = this.cUSTOMERNAME;
    data['CARD_STA'] = this.cARDSTA;
    data['TRAN_AMT'] = this.tRANAMT;
    data['TRAN_TIME'] = this.tRANTIME;
    data['CUSTOMER_ID'] = this.cUSTOMERID;
    data['PRDORDTYPENAME'] = this.pRDORDTYPENAME;
    data['GOOD_TYPENO'] = this.gOODTYPENO;
    data['TRAN_DATE'] = this.tRANDATE;
    data['DETAILIST'] = this.dETAILIST;
    data['METER_NO'] = this.mETERNO;
    data['CCY'] = this.cCY;
    data['GOOD_TYPE'] = this.gOODTYPE;
    data['POWER_AMT'] = this.pOWERAMT;
    data['ISAGENTFIRST'] = this.iSAGENTFIRST;
    data['ORDSTATUS'] = this.oRDSTATUS;
    data['AGENTLEVEL'] = this.aGENTLEVEL;
    data['ISFIRST'] = this.iSFIRST;
    data['UNILITY_NAME'] = this.uNILITYNAME;
    data['PRDORDTYPE'] = this.pRDORDTYPE;
    data['TOKEN'] = this.tOKEN;
    data['BIZTYPE'] = this.bIZTYPE;
    return data;
  }
}