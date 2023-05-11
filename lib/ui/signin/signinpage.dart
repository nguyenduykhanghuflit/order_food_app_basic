// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import signupscreen??
import 'components/body.dart';

class SignInPage extends StatelessWidget {
  static const routeName = '/signin';

  const SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
