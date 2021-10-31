import 'package:flutter/material.dart';
import 'package:pramaan/src/services/auth/state_check.dart';
import 'package:pramaan/src/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  Future<bool> future() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: future.call(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) return const StateCheck();
          return Center(
            child: Image.asset(
              Assets.logo,
              width: 200,
              height: 200,
            ),
          );
        },
      ),
    );
  }
}
