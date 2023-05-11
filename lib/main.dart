import 'package:flutter/material.dart';
import 'package:order_food_v1/constant/constants.dart';
import 'package:order_food_v1/ui/cart/cartpage.dart';
import 'package:order_food_v1/ui/detail/productpage.dart';
import 'package:order_food_v1/ui/homepage/homepage.dart';
import 'package:order_food_v1/ui/signin/signinpage.dart';
import 'package:order_food_v1/ui/signup/signuppage.dart';
import 'package:order_food_v1/splashpage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter_demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashPage(),
      routes: <String, WidgetBuilder>{
        signInRoute: (context) => const SignInPage(),
        signUpRoute: (context) => const SignUpPage(),
        homeRoute: (context) => HomePage(),
        productRoute: (context) => const ProductPage(),
        cartRoute: (context) => CartPage(),
      },
    );
  }
}
