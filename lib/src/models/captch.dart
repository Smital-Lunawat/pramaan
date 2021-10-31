// class CaptchaModel {
//   String? status;
//   String? captchaBase64String;
//   String? captchaTxnId;
//   String? requestedDate;
//   int? statusCode;
//   String? message;

//   CaptchaModel(
//       {this.status, this.captchaBase64String, this.captchaTxnId, this.requestedDate, this.statusCode, this.message});

//   CaptchaModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     captchaBase64String = json['captchaBase64String'];
//     captchaTxnId = json['captchaTxnId'];
//     requestedDate = json['requestedDate'];
//     statusCode = json['statusCode'];
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['captchaBase64String'] = captchaBase64String;
//     data['captchaTxnId'] = captchaTxnId;
//     data['requestedDate'] = requestedDate;
//     data['statusCode'] = statusCode;
//     data['message'] = message;
//     return data;
//   }
// }
