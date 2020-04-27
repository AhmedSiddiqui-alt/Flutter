import 'package:flutter/material.dart';
import './register.dart';
import './sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  void toggleView() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin == true) {
      return SignIn(toggle: toggleView);
    } else {
      return Register(toggle: toggleView);
    }
  }
}
