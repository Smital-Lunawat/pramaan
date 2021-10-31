import 'package:firebase_auth/firebase_auth.dart';

PageRoutes pageRoutes = PageRoutes();
FireServer fireServer = FireServer();
Constants constants = Constants();
APIUris apiUris = APIUris();

class PageRoutes {
  static const String routeHome = '/';
  static const String routeState = '/stateCheck';
  static const String routeLogin = '/login';
  static const String routeCustomerHome = '/customerHome';
  static const String routeVerifierHome = '/verifierHome';
  static const String routeCaptcha = '/captcha';
  static const String routeOtp = '/otp';
  static const String routeUserData = '/userData';
}

class FireServer {
  FirebaseAuth mAuth = FirebaseAuth.instance;
}

class Assets {
  static const String logo = 'assets/images/logo.png';
  static const String authenticate = 'assets/lottie/authenticate.json';
  static const String id = 'assets/lottie/id.json';
  static const String connect = 'assets/lottie/connect.json';
  static const String otp = 'assets/lottie/otp.json';
  static const String noData = 'assets/lottie/no_data.json';
  static const String imageLoading = 'assets/lottie/image_loading.json';
}

class Constants {
  List<Map<String, String>> splashData = <Map<String, String>>[
    <String, String>{
      'title': 'Apna Pramaan Apni Pehchaan',
      'asset': Assets.id,
      'content': 'Have a quick and easy identification at any place, any time 😎',
    },
    <String, String>{
      'title': 'Verification made Effortless',
      'asset': Assets.authenticate,
      'content': 'Authenticate and verify your identity with the concerned personnel with just a click 😎',
    },
    <String, String>{
      'title': 'Connect with Care',
      'asset': Assets.connect,
      'content': 'Data can be shared securely with the verifier by using the share feature right from the app 😎',
    }
  ];
}

class APIUris {
  static const String captchaUri = 'https://stage1.uidai.gov.in/unifiedAppAuthService/api/v2/get/captcha';
  static const String otpGeneratorUri = 'https://stage1.uidai.gov.in/unifiedAppAuthService/api/v2/generate/aadhaar/otp';
  static const String generateVIDUri = 'https://stage1.uidai.gov.in/vidwrapper/generate';
  static const String retrieveVIDUri = 'https://stage1.uidai.gov.in/vidwrapper/retrieve';
  static const String fetchKYCDataUri = 'https://stage1.uidai.gov.in/eAadhaarService/api/downloadOfflineEkyc';
}

class APIBodies {
  static const String captchaBody = '''{
    "langCode": "en",
    "captchaLength": 3,
    "captchaType": 2
  }
  ''';
  static String otpGeneratorBody({
    required String? uid,
    required String? captchaTxnId,
    required String? captchaValue,
    required String? uuid,
  }) =>
      '''{
    "uidNumber": "$uid",
    "captchaTxnId": "$captchaTxnId",
    "captchaValue": "$captchaValue",
    "transactionId": "MYAADHAAR:$uuid"
  }''';

  static String generateVIDBody({
    required String? uid,
    required String? mobile,
    required String? otp,
    required String? otpTxnId,
  }) =>
      '''{
 "uid" : "$uid",
 "mobile" : "$mobile",
 "otp" : "$otp",
 "otpTxnId" : "$otpTxnId"
}''';

  static String retrieveVIDBody({
    required String? uid,
    required String? mobile,
    required String? otp,
    required String? otpTxnId,
  }) =>
      '''{
 "uid" : "$uid",
 "mobile" : "$mobile",
 "otp" : "$otp",
 "otpTxnId" : "$otpTxnId"
}''';

  static String fetchKYCBody({
    required String? uid,
    required String? pin,
    required String? otp,
    required String? txnNumber,
  }) =>
      '''{
 "txnNumber": "$txnNumber",
 "otp": "$otp",
 "shareCode": "$pin",
 "uid": "$uid" 
}''';
}
