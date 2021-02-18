class CodeModel {
  String rSPCOD;
  AUTH aUTH;
  String rSPMSG;

  CodeModel({this.rSPCOD, this.aUTH, this.rSPMSG});

  CodeModel.fromJson(Map<String, dynamic> json) {
    rSPCOD = json['RSPCOD'];
    aUTH = json['AUTH'] != null ? new AUTH.fromJson(json['AUTH']) : null;
    rSPMSG = json['RSPMSG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RSPCOD'] = this.rSPCOD;
    if (this.aUTH != null) {
      data['AUTH'] = this.aUTH.toJson();
    }
    data['RSPMSG'] = this.rSPMSG;
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