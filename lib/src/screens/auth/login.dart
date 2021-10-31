import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pramaan/src/services/auth/auth.dart';
import 'package:pramaan/src/utils/app_theme.dart';
import 'package:pramaan/src/utils/constants.dart';
import 'package:pramaan/src/widgets/custom_button.dart';
import 'package:pramaan/src/widgets/splash_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentPage = 0;
  PageController controller = PageController();
  GoogleSignInProvider? gAuth;
  @override
  void initState() {
    super.initState();
    gAuth = Provider.of<GoogleSignInProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VxBox(
          child: VStack(
            <Widget>[
              VxBox(
                child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: controller,
                    itemCount: constants.splashData.length,
                    onPageChanged: (int value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return SplashContent(
                        constants.splashData[index]['title']!,
                        constants.splashData[index]['asset']!,
                        constants.splashData[index]['content']!,
                      );
                    }),
              ).make().expand(flex: 3),
              VxBox(
                child: <Widget>[
                  HStack(
                    List<Widget>.generate(
                      constants.splashData.length,
                      (int index) => pageDots(index: index),
                    ),
                    alignment: MainAxisAlignment.center,
                  ),
                ].vStack(),
              ).makeCentered().expand(),
              CustomButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (currentPage != 2) {
                    setState(() {
                      currentPage = 3;
                      controller
                          .animateToPage(
                        2,
                        duration: const Duration(microseconds: 600),
                        curve: Curves.linear,
                      )
                          .whenComplete(() async {
                        await gAuth!.login();
                      });
                    });
                  } else {
                    await gAuth!.login();
                  }
                },
                child: currentPage == 2
                    ? 'Login with Google'.text.white.fontFamily('LexendDeca').bold.lg.makeCentered()
                    : 'Get Started'.text.white.fontFamily('LexendDeca').bold.lg.makeCentered(),
              ),
            ],
            alignment: MainAxisAlignment.spaceEvenly,
          ),
        ).make().w(double.infinity).centered(),
      ),
    );
  }

  Widget pageDots({required int index}) {
    return VxAnimatedBox()
        .animDuration(const Duration(milliseconds: 300))
        .margin(const EdgeInsets.symmetric(horizontal: 5))
        .withRounded()
        .color(currentPage == index ? AppColors.appMainColor : const Color(0xFFD6D6D6))
        .height(6)
        .width(currentPage == index ? 20 : 6)
        .makeCentered();
  }
}
