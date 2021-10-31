import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pramaan/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class KYCModel extends ChangeNotifier {
  /// eKycXML private variable
  String? _eKycXML;

  /// eKycXML getter
  String? get eKycXML => _eKycXML;

  /// eKycXML setter
  set eKycXML(String? value) {
    _eKycXML = value;
    notifyListeners();
  }

  /// status private variable
  String? _status;

  /// status getter
  String? get status => _status;

  /// status setter
  set status(String? value) {
    _status = value;
    notifyListeners();
  }

  /// uidNumber private variable
  String? _uidNumber;

  /// uidNumber getter
  String? get uidNumber => _uidNumber;

  /// uidNumber setter
  set uidNumber(String? value) {
    _uidNumber = value;
    notifyListeners();
  }

  // fetch KYC data from post request
  Future<void> fetchKYC({
    required String? uid,
    required String? pin,
    required String? otp,
    required String? txnNumber,
  }) async {
    String bodyData = APIBodies.fetchKYCBody(
      otp: otp,
      pin: pin,
      txnNumber: txnNumber,
      uid: uid,
    );
    print('Fetch KYC - \n' + bodyData);
    try {
      http.Response postResponse = await http.post(
        Uri.parse(APIUris.fetchKYCDataUri),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: bodyData,
      );
      Map<String, dynamic> response = jsonDecode(postResponse.body);

      /// setting eKycXML value
      eKycXML = response['eKycXML'].toString();

      /// setting status value
      status = response['status'].toString();

      /// setting uidNumber value
      uidNumber = response['uidNumber'].toString();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  /// Function to convert base64 to zip file and write the data to file.
  ///
  /// Returns `true` if file is written successfully
  /// else `false`.
  Future<bool> writeToFile(String? eKycXML, {Function? loading}) async {
    /// Check if the base64 is null
    if (eKycXML == null) {
      return false;
    }

    /// else try to write the data to a zip file.
    try {
      /// Get the application's directory path.
      String filePath = (await getExternalStorageDirectory())!.path;
      String fileName = 'kyc.zip';
      String filePathName = filePath + '/' + fileName;
      File file = File(filePathName);
      File zipFile = await file.writeAsBytes(base64.decode(eKycXML));
      print('File written to ${zipFile.path}');
      return true;
    } on MissingPluginException catch (e) {
      throw ('Plugin needs a reload. Read the error below to know more: \n' + e.toString());
    } on Exception catch (e) {
      throw (e.toString());
    }
  }
}
