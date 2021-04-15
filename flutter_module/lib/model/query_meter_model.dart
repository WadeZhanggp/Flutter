
class QueryMeterModel {
  String rSPCOD;
  AUTH aUTH;
  String rSPMSG;
  DATA dATA;
  String ENEL_ID;
  String METER_NO;

  QueryMeterModel({this.rSPCOD, this.aUTH, this.rSPMSG, this.dATA,this.ENEL_ID});

  QueryMeterModel.fromJson(Map<String, dynamic> json) {
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
  String mETERNO;
  String cCY;
  String bIZTYPE;
  String uSERNAME;
  String cUSTOMERID;
  List<DATAAMT> dATAAMT;

  DATA(
      {this.mETERNO,
        this.cCY,
        this.bIZTYPE,
        this.uSERNAME,
        this.cUSTOMERID,
        this.dATAAMT});

  DATA.fromJson(Map<String, dynamic> json) {
    mETERNO = json['METER_NO'];
    cCY = json['CCY'];
    bIZTYPE = json['BIZ_TYPE'];
    uSERNAME = json['USER_NAME'];
    cUSTOMERID = json['CUSTOMER_ID'];
    if (json['DATA_AMT'] != null) {
      dATAAMT = new List<DATAAMT>();
      json['DATA_AMT'].forEach((v) {
        dATAAMT.add(new DATAAMT.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['METER_NO'] = this.mETERNO;
    data['CCY'] = this.cCY;
    data['BIZ_TYPE'] = this.bIZTYPE;
    data['USER_NAME'] = this.uSERNAME;
    data['CUSTOMER_ID'] = this.cUSTOMERID;
    if (this.dATAAMT != null) {
      data['DATA_AMT'] = this.dATAAMT.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DATAAMT {
  String fEEAMT;
  String uSERAMOUNT;

  DATAAMT({this.fEEAMT, this.uSERAMOUNT});

  DATAAMT.fromJson(Map<String, dynamic> json) {
    fEEAMT = json['FEE_AMT'];
    uSERAMOUNT = json['USER_AMOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FEE_AMT'] = this.fEEAMT;
    data['USER_AMOUNT'] = this.uSERAMOUNT;
    return data;
  }
}