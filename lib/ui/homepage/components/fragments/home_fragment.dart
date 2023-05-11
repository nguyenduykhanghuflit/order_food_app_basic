import 'package:flutter/material.dart';

import 'home_fragment_categories.dart';
import 'home_fragment_product.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          CategoriesStore(),
           ProductPopular(),
        ],
      ),
    );
  }
}
