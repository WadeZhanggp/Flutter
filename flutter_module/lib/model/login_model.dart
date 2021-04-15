class LoginModel {
  String rSPCOD;
  AUTH aUTH;
  String rSPMSG;
  DATA dATA;

  LoginModel({this.rSPCOD, this.aUTH, this.rSPMSG, this.dATA});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String lEVELACT;
  String cONTACTSPHONE;
  int cUSTGRADE;
  String sESSIONID;
  String rEAD4428;
  String kEY;
  String cONTACTNO;
  String aCCOUNT;
  String rEAD4442;

  DATA(
      {this.cCY,
        this.lEVELACT,
        this.cONTACTSPHONE,
        this.cUSTGRADE,
        this.sESSIONID,
        this.rEAD4428,
        this.kEY,
        this.cONTACTNO,
        this.aCCOUNT,
        this.rEAD4442});

  DATA.fromJson(Map<String, dynamic> json) {
    cCY = json['CCY'];
    lEVELACT = json['LEVELACT'];
    cONTACTSPHONE = json['CONTACTS_PHONE'];
    cUSTGRADE = json['CUST_GRADE'];
    sESSIONID = json['SESSION_ID'];
    rEAD4428 = json['READ4428'];
    kEY = json['KEY'];
    cONTACTNO = json['CONTACT_NO'];
    aCCOUNT = json['ACCOUNT'];
    rEAD4442 = json['READ4442'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CCY'] = this.cCY;
    data['LEVELACT'] = this.lEVELACT;
    data['CONTACTS_PHONE'] = this.cONTACTSPHONE;
    data['CUST_GRADE'] = this.cUSTGRADE;
    data['SESSION_ID'] = this.sESSIONID;
    data['READ4428'] = this.rEAD4428;
    data['KEY'] = this.kEY;
    data['CONTACT_NO'] = this.cONTACTNO;
    data['ACCOUNT'] = this.aCCOUNT;
    data['READ4442'] = this.rEAD4442;
    return data;
  }


}