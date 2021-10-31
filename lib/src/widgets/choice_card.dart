import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pramaan/src/utils/app_theme.dart';

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.transparent,
      hoverElevation: 0,
      focusElevation: 0,
      elevation: 0,
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.white,
        ),
        child: Center(
          child: <Widget>[
            VxBox(
              child: Icon(
                icon,
                color: Colors.black54,
                size: 30,
              ),
            )
                .withDecoration(
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.appMainColor.withOpacity(0.3),
                  ),
                )
                .height(60)
                .width(60)
                .make(),
            Text(
              text!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ].vStack(
            alignment: MainAxisAlignment.spaceEvenly,
            axisSize: MainAxisSize.max,
          ),
        ),
      ),
    );
  }
}
