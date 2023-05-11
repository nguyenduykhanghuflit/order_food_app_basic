import 'package:flutter/material.dart';
import 'signinform.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          // headerScreeen(context),
          const SignInForm(),
          // footerScreeen(context),
        ],
      ),
    ));
  }

  // Widget headerScreeen(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: MediaQuery.of(context).size.height * 0.2,
  //     alignment: Alignment.bottomRight,
  //     child: Image.asset('assets/img/dish.png'),
  //   );
  // }

  // Widget footerScreeen(BuildContext context) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     alignment: Alignment.bottomLeft,
  //     child: Image.asset('assets/img/dish_2.png'),
  //   );
  // }
}
