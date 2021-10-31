import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashContent extends StatelessWidget {
  const SplashContent(
    this.title,
    this.asset,
    this.content, {
    Key? key,
  }) : super(key: key);
  final String title, asset, content;
  @override
  Widget build(BuildContext context) {
    return VStack(
      <Widget>[
        title.text.fontFamily('Inter').bold.xl2.align(TextAlign.center).makeCentered().py32(),
        Lottie.asset(asset).centered().w(context.screenWidth * 0.75),
        content.text.fontFamily('Inter').center.align(TextAlign.center).xl.makeCentered().px24(),
      ],
      alignment: MainAxisAlignment.spaceBetween,
      crossAlignment: CrossAxisAlignment.center,
    );
  }
}
