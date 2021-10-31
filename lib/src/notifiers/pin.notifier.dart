import 'dart:math';
import 'dart:developer' as console;
import 'package:flutter/material.dart';

class Pin extends ChangeNotifier {
  /// pin private variable
  String? _pin;

  /// pin getter
  String? get pin => _pin;

  /// pin setter
  set pin(String? value) {
    _pin = value;
    notifyListeners();
  }

  /// Function that generates 4 digit random number between 1000 and 9999 and return the number as String.
  void generatePin() {
    /// Random object
    Random random = Random();

    /// generate a number b/w 0 and 8999 and add 1000
    int randomPin = random.nextInt(9000) + 1000;

    /// set the pin
    pin = randomPin.toString();
    console.log('Pin is ' + pin!);
  }
}
