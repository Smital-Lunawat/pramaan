import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final IconData? icon;
  final bool isPassword;
  final ValueChanged<String>? onChanged;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              widget.icon,
              color: Colors.black87,
            ),
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
