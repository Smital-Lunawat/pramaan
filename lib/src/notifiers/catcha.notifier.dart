import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pramaan/src/utils/constants.dart';

class CaptchaModel extends ChangeNotifier {
  /// Captcha private variables
  String? _captcha;

  /// getter for captcha
  String? get captcha => _captcha;

  /// setter for captcha
  set captcha(String? value) {
    _captcha = value;
    notifyListeners();
  }

  /// captchaTxnId private variable
  String? _captchaTxnId;

  /// getter for captchaTxnId
  String? get captchaTxnId => _captchaTxnId;

  /// setter for captchaTxnId
  set captchaTxnId(String? value) {
    _captchaTxnId = value;
    notifyListeners();
  }

  /// statusCode private variable
  int? _statusCode;

  /// getter for statusCode
  int? get statusCode => _statusCode;

  /// setter for statusCode
  set statusCode(int? value) {
    _statusCode = value;
    notifyListeners();
  }

  /// This function is used to get captcha from server using http post request
  /// with headers and body.
  ///
  /// Header: `Content-Type: application/json`
  ///
  /// body: [APIBodies.captchaBody]
  Future<void> captchaGenerator() async {
    try {
      http.Response postResponse = await http.post(
        Uri.parse(APIUris.captchaUri),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: APIBodies.captchaBody,
      );

      /// Capturing the response body
      Map<String, dynamic> captcharesponse = json.decode(postResponse.body);

      /// Setting the captcha value.
      captcha = captcharesponse['captchaBase64String'];

      /// Setting the captchaTxnId value
      captchaTxnId = captcharesponse['captchaTxnId'];

      /// Setting the statusCode value
      statusCode = captcharesponse['statusCode'];
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
