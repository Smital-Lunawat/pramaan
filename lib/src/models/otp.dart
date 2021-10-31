class OtpModel {
  int? uidNumber;
  int? mobileNumber;
  String? txnId;
  String? status;
  String? message;

  OtpModel({this.uidNumber, this.mobileNumber, this.txnId, this.status, this.message});

  OtpModel.fromJson(Map<String, dynamic> json) {
    uidNumber = json['uidNumber'];
    mobileNumber = json['mobileNumber'];
    txnId = json['txnId'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['uidNumber'] = uidNumber;
    data['mobileNumber'] = mobileNumber;
    data['txnId'] = txnId;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
