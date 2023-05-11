import 'package:flutter/material.dart';
import 'package:order_food_v1/ui/homepage/components/body.dart';

class HomePage extends StatelessWidget {
  int selectIndex = 0;
  static const routeName = "/home_screen";

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}
