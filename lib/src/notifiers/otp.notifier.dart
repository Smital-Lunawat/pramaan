import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pramaan/src/utils/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class OTPModel extends ChangeNotifier {
  /// transaction ID private variable
  String? _txnId;

  /// Getter for transaction ID
  String? get txnId => _txnId;

  /// setter for transaction ID
  set txnId(String? txnId) {
    _txnId = txnId;
    notifyListeners();
  }

  /// success code private variable
  String? _status;

  /// Getter for success code
  String? get status => _status;

  /// setter for success code
  set status(String? status) {
    _status = status;
    notifyListeners();
  }

  /// uidNumber private variable
  String? _uidNumber;

  /// Getter for uidNumber
  String? get uidNumber => _uidNumber;

  /// Setter for uidNumber
  set uidNumber(String? uidNumber) {
    _uidNumber = uidNumber;
    notifyListeners();
  }

  Future<void> otpGenerator(String captcha, String? captchaTxnId, {String? aadhar}) async {
    String uuid = const Uuid().v4();
    String bodyData = APIBodies.otpGeneratorBody(
      uid: aadhar,
      captchaTxnId: captchaTxnId,
      captchaValue: captcha,
      uuid: uuid,
    );
    print('OTP generated - \n' + bodyData);
    try {
      http.Response postResponse = await http.post(
        Uri.parse(APIUris.otpGeneratorUri),
        headers: <String, String>{
          'x-request-id': uuid,
          'appid': 'MYAADHAAR',
          'Accept-Language': 'en_in',
          'Content-Type': 'application/json',
        },
        body: bodyData,
      );
      Map<String, dynamic> otpResponse = json.decode(postResponse.body);

      /// set otp
      txnId = otpResponse['txnId'];

      /// set status
      status = otpResponse['status'];

      /// set uidNumber
      uidNumber = otpResponse['uidNumber'].toString();
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
