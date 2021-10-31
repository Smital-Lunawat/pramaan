import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pramaan/src/screens/vendor/otp_screen.dart';
import 'package:pramaan/src/screens/vendor/photo.dart';
import 'package:pramaan/src/screens/vendor/vendor_home.dart';
import 'package:pramaan/src/services/providers.dart';
import 'package:pramaan/src/screens/auth/login.dart';
import 'package:pramaan/src/screens/splash_screen.dart';
import 'package:pramaan/src/services/auth/state_check.dart';
import 'package:pramaan/src/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MultipleProvider(
      MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? page;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: PageRoutes.routeHome,
      routes: <String, WidgetBuilder>{
        PageRoutes.routeHome: (BuildContext context) => const SplashScreen(),
        PageRoutes.routeState: (BuildContext context) => const StateCheck(),
        PageRoutes.routeLogin: (BuildContext context) => const LoginScreen(),
        PageRoutes.routeCustomerHome: (BuildContext context) => const VendorHome(),
        PageRoutes.routeOtp: (BuildContext context) => const CustomerOtpScreen(),
        PageRoutes.routeUserData: (BuildContext context) => const QRScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case PageRoutes.routeHome:
            page = const SplashScreen();
            return;
          case PageRoutes.routeState:
            page = const StateCheck();
            return;
          case PageRoutes.routeLogin:
            page = const LoginScreen();
            return;
          case PageRoutes.routeCustomerHome:
            page = const VendorHome();
            return;
          case PageRoutes.routeOtp:
            page = const CustomerOtpScreen();
            return;
          case PageRoutes.routeUserData:
            page = const QRScreen();
            return;
          default:
            return null;
        }
      },
    );
  }
}
