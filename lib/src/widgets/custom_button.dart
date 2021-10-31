import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pramaan/src/utils/app_theme.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget? child;
  final double? width;
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => Colors.transparent),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.appMainColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      onPressed: widget.onPressed,
      child: VxBox(
        child: widget.child,
      ).make().w(widget.width ?? double.infinity).h4(context),
    ).centered().p16();
  }
}
