import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:pramaan/src/widgets/choice_card.dart';

class UserChoice extends StatefulWidget {
  const UserChoice({Key? key}) : super(key: key);

  @override
  _UserChoiceState createState() => _UserChoiceState();
}

class _UserChoiceState extends State<UserChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: <Widget>[
          ChoiceCard(
            text: 'Customer',
            onPressed: () {
              Navigator.pushNamed(context, '/customerHome');
            },
            icon: Icons.face,
          ),
          ChoiceCard(
            text: 'Verifier',
            onPressed: () {
              Navigator.pushNamed(context, '/verifierHome');
            },
            icon: Icons.fingerprint_rounded,
          ),
        ].hStack(
          alignment: MainAxisAlignment.spaceEvenly,
          crossAlignment: CrossAxisAlignment.center,
          axisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}
