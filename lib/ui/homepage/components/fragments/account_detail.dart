import 'package:flutter/material.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({super.key});

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _divider(),
            emailTextFormField(),
            _divider(),
            passwordTextFormField(),
            _divider(),
            conformTextFormField(),
            _divider(),
            _buildContinue(),
            _divider(),
            _buildAltLogin()
          ],
        ),
      ),
    );
  }

  Widget _divider() => const SizedBox(height: 30.0);

  Widget _buildContinue() {
    return SizedBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {},
        child: const Text(
          'Continue',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildAltLogin() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
                color: Color(0xfff5f6f9), shape: BoxShape.circle),
            child: const Image(
              image: AssetImage('assets/icons/facebook.png'),
            ),
          ),
          Container(
            height: 40.0,
            width: 40.0,
            margin: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
                color: Color(0xfff5f6f9), shape: BoxShape.circle),
            child: const Image(
              image: AssetImage('assets/icons/google.png'),
            ),
          ),
          Container(
            height: 40.0,
            width: 40.0,
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
                color: Color(0xfff5f6f9), shape: BoxShape.circle),
            child: const Image(
              image: AssetImage('assets/icons/twitter.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock_outline),
      ),
    );
  }

  Widget conformTextFormField() {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter your password',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_clock_outlined)),
    );
  }
}
