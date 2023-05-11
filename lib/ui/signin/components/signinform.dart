// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unused_field

import 'package:flutter/material.dart';
import 'package:order_food_v1/constant/constants.dart';
import 'package:order_food_v1/services/ApiServices.dart';
import 'package:order_food_v1/ui/signup/signuppage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utilities/utilities.dart';
import '../../dialog/show_dialog.dart';
import '../../homepage/homepage.dart';
//import 'package:th1_3/pages/signUp/signuppage.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final username = TextEditingController();
  final password = TextEditingController();

  String msg = "err";
  FToast? fToast;
  @override
  void initState() {
    super.initState();
  }

  Future<void> handleLogin(us, pw) async {
    dynamic res = await ApiServices().login(us, pw);

    if (res['success']) {
      // ignore: use_build_context_synchronously
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.setString("token", res['data']);
      final String? token = prefs.getString('token');
      print(token);
      if (token != "" || token != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, homeRoute);
      }
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            message: res['message'],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast?.init(context);
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          //logo
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("Food Now",
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                  const Text(
                    "Sign in with your email and password \nor continue with social media",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                  )
                ],
              )),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail_outline)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  //password
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_clock_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //button login
                  SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () async {
                            String email = username.text;
                            String pw = password.text;
                            handleLogin(email, pw);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              foregroundColor: Colors.green),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                  SizedBox(
                    height: 10,
                  ),

                  //create account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.green, fontSize: 14),
                      ),
                      GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(context, signUpRoute);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ]),
          )
        ]));
  }
}
