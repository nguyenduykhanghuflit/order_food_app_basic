// ignore_for_file: prefer_const_constructors

// ignore: unused_import

import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../utilities/utilities.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var email = TextEditingController();
  final password = TextEditingController();
  final conform = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            emailTextFormField(),
            const SizedBox(
              height: 30,
            ),
            passwordTextFormField(),
            const SizedBox(
              height: 30,
            ),
            conformTextFormField(),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigator.pop(context,
                      //     User(username: email.text, password: conform.text));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         height: 40,
            //         width: 40,
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //             color: Color(0xFFF5F6F9), shape: BoxShape.circle),
            //         child: Image.asset('assets/icons/facebook.png'),
            //       ),
            //       Container(
            //         height: 40,
            //         width: 40,
            //         margin: EdgeInsets.only(left: 10, right: 10),
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //             color: Color(0xFFF5F6F9), shape: BoxShape.circle),
            //         child: Image.asset('assets/icons/google.png'),
            //       ),
            //       Container(
            //         height: 40,
            //         width: 40,
            //         padding: EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //             color: Color(0xFFF5F6F9), shape: BoxShape.circle),
            //         child: Image.asset('assets/icons/twitter.png'),
            //       ),
            //     ],
            //   ),
            // )
          ]),
        ));
  }

  emailTextFormField() {
    return TextFormField(
      //controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your email",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)),

      validator: (email) {
        return Utilities.validateEmail(email!);
      },

      onSaved: (value) {
        setState(() {
          email.text = value!;
        });
      },
    );
  }

  passwordTextFormField() {
    return TextFormField(
      key: _passKey,
      controller: password,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
      validator: (passwordKey) {
        return Utilities.validatePassword(passwordKey!);
      },
    );
  }

  conformTextFormField() {
    return TextFormField(
      //controller: conform,
      obscureText: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Re-enter your password",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),

      validator: (conformPassword) {
        var pass = _passKey.currentState?.value;
        return Utilities.conformPassword(conformPassword!, pass);
      },

      onSaved: (value) {
        setState(() {
          conform.text = value!;
        });
      },
    );
  }
}
