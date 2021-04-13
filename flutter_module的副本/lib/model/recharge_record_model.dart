
class RechargeRecordModel {
  String rSPCOD;
  AUTH aUTH;
  String rSPMSG;
  DATA dATA;

  RechargeRecordModel({this.rSPCOD, this.aUTH, this.rSPMSG, this.dATA});

  RechargeRecordModel.fromJson(Map<String, dynamic> json) {
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
  String cCY;
  String tRANAMT;
  List<TRANRECORD> tRANRECORD;

  DATA({this.cCY, this.tRANAMT, this.tRANRECORD});

  DATA.fromJson(Map<String, dynamic> json) {
    cCY = json['CCY'];
    tRANAMT = json['TRAN_AMT'];
    if (json['TRAN_RECORD'] != null) {
      tRANRECORD = new List<TRANRECORD>();
      json['TRAN_RECORD'].forEach((v) {
        tRANRECORD.add(new TRANRECORD.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CCY'] = this.cCY;
    data['TRAN_AMT'] = this.tRANAMT;
    if (this.tRANRECORD != null) {
      data['TRAN_RECORD'] = this.tRANRECORD.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TRANRECORD {
  String gOODTYPE;
  String pRDORDNO;
  String tRANAMT;
  String tRANTIME;
  String oRDSTATUS;
  String tRANDATE;
  int gOODTYPENO;
  String pRDORDTYPENAME;
  int pRDORDTYPE;

  TRANRECORD(
      {this.gOODTYPE,
        this.pRDORDNO,
        this.tRANAMT,
        this.tRANTIME,
        this.oRDSTATUS,
        this.tRANDATE,
        this.gOODTYPENO,
        this.pRDORDTYPENAME,
        this.pRDORDTYPE});

  TRANRECORD.fromJson(Map<String, dynamic> json) {
    gOODTYPE = json['GOOD_TYPE'];
    pRDORDNO = json['PRDORDNO'];
    tRANAMT = json['TRAN_AMT'];
    tRANTIME = json['TRAN_TIME'];
    oRDSTATUS = json['ORDSTATUS'];
    tRANDATE = json['TRAN_DATE'];
    gOODTYPENO = json['GOOD_TYPENO'];
    pRDORDTYPENAME = json['PRDORDTYPENAME'];
    pRDORDTYPE = json['PRDORDTYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GOOD_TYPE'] = this.gOODTYPE;
    data['PRDORDNO'] = this.pRDORDNO;
    data['TRAN_AMT'] = this.tRANAMT;
    data['TRAN_TIME'] = this.tRANTIME;
    data['ORDSTATUS'] = this.oRDSTATUS;
    data['TRAN_DATE'] = this.tRANDATE;
    data['GOOD_TYPENO'] = this.gOODTYPENO;
    data['PRDORDTYPENAME'] = this.pRDORDTYPENAME;
    data['PRDORDTYPE'] = this.pRDORDTYPE;
    return data;
  }
}