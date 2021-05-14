class PreAlipayModel {
  String rSPCOD;
  AUTH aUTH;
  String rSPMSG;
  DATA dATA;

  PreAlipayModel({this.rSPCOD, this.aUTH, this.rSPMSG, this.dATA});

  PreAlipayModel.fromJson(Map<String, dynamic> json) {
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
  String pAYINFO;

  DATA({this.pAYINFO});

  DATA.fromJson(Map<String, dynamic> json) {
    pAYINFO = json['PAYINFO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PAYINFO'] = this.pAYINFO;
    return data;
  }
}