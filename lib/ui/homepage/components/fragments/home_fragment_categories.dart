import 'package:flutter/material.dart';
import 'package:order_food_v1/services/ApiServices.dart';
import '../../../../models/categories.dart';

class CategoriesStore extends StatefulWidget {
  const CategoriesStore({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoriesStoreState createState() => _CategoriesStoreState();
}

class _CategoriesStoreState extends State<CategoriesStore> {
  dynamic _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final categories = await ApiServices().getCategories();
    dynamic response = categories['success'] ? categories['data'] : null;
    if (response != null) {
      for (var item in response) {
        item["image"] = ApiServices().apiEndpoint + item["image"];
      }
    }
    setState(() {
      _categories = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _buildLabel(),
            const SizedBox(height: 10.0),
            _buildListView(context, _categories),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, dynamic categories) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 180.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoriesItem(category: categories[index]);
        },
      ),
    );
  }

  Row _buildLabel() {
    return Row(
      children: const [
        Expanded(
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
        Text(
          'See more',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CategoriesItem extends StatelessWidget {
  dynamic category;
  CategoriesItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 160.0,
          height: 110.0,
          padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
          child: Image(
            image: NetworkImage(category['image']),
          ),
        ),
        Text(
          category['title'],
          style: TextStyle(
              color: Color(0xFFEAB676),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
