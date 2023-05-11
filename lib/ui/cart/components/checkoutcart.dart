// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

class CheckOutCart extends StatelessWidget {
  double sum;
  CheckOutCart({super.key, required this.sum});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          height: 50,
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.green))),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            onPressed: () {},
            child: Text(
              "Sum:${sum}",
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: TextButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        side: BorderSide(color: Colors.green))),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            onPressed: () {},
            child: Text("Check out".toUpperCase(),
                style: const TextStyle(fontSize: 14)),
          ),
        )
      ],
    );
  }
}
