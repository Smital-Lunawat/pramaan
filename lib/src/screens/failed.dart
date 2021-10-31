import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pramaan/src/utils/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class FailedScreen extends StatefulWidget {
  const FailedScreen({Key? key}) : super(key: key);

  @override
  _FailedScreenState createState() => _FailedScreenState();
}

class _FailedScreenState extends State<FailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        Lottie.asset(
          Assets.noData,
          height: 150,
          repeat: true,
        ).centered(),
        IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () async => Navigator.pushNamedAndRemoveUntil(context, '/customerHome', ModalRoute.withName('/')),
        )
      ].stack(),
    );
  }
}
