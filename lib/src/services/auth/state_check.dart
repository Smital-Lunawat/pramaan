import 'package:flutter/material.dart';
import 'package:pramaan/src/screens/vendor/vendor_home.dart';
import 'package:provider/provider.dart';
import 'package:pramaan/src/screens/auth/login.dart';
import 'package:pramaan/src/services/auth/auth.dart';
import 'package:pramaan/src/utils/constants.dart';

class StateCheck extends StatelessWidget {
  const StateCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleSignInProvider provider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      body: ChangeNotifierProvider<GoogleSignInProvider>(
        create: (BuildContext context) => GoogleSignInProvider(),
        child: StreamBuilder<dynamic>(
          stream: fireServer.mAuth.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (provider.isSigningIn) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              );
            } else {
              if (snapshot.hasData) {
                return const VendorHome();
              } else {
                return const LoginScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
