import 'package:flutter/material.dart';
import 'package:pramaan/src/notifiers/catcha.notifier.dart';
import 'package:pramaan/src/notifiers/db.notifier.dart';
import 'package:pramaan/src/notifiers/kyc.notifier.dart';
import 'package:pramaan/src/notifiers/otp.notifier.dart';
import 'package:pramaan/src/notifiers/pin.notifier.dart';
import 'package:pramaan/src/services/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MultipleProvider extends StatelessWidget {
  const MultipleProvider(
    this.child, {
    Key? key,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<GoogleSignInProvider>(
          create: (BuildContext context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider<CaptchaModel>(
          create: (BuildContext context) => CaptchaModel(),
        ),
        ChangeNotifierProvider<OTPModel>(
          create: (BuildContext context) => OTPModel(),
        ),
        ChangeNotifierProvider<KYCModel>(
          create: (BuildContext context) => KYCModel(),
        ),
        ChangeNotifierProvider<Pin>(
          create: (BuildContext context) => Pin(),
        ),
        ChangeNotifierProvider<Database>(
          create: (BuildContext context) => Database(),
        ),
      ],
      child: child,
    );
  }
}
