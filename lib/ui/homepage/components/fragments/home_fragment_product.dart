import 'package:flutter/material.dart';
import '../../../../constant/constants.dart';
import '../../../../services/ApiServices.dart';
import '../../../detail/productpage.dart';
import 'package:intl/intl.dart';
// ignore: unnecessary_import
import 'dart:ui';

class ProductPopular extends StatefulWidget {
  const ProductPopular({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ProductPopularStatefulState createState() => _ProductPopularStatefulState();
}

class _ProductPopularStatefulState extends State<ProductPopular> {
  dynamic _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final products = await ApiServices().getProduct();
    dynamic response = products['success'] ? products['data']['data'] : null;
    print(response);
    setState(() {
      _products = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildLabel(),
          const SizedBox(height: 10.0),
          _buildGridView(_products),
        ],
      ),
    );
  }
}

Widget _buildGridView(dynamic products) {
  return GridView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    primary: false,
    itemCount: products.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.7,
    ),
    itemBuilder: (context, index) {
      return ProductItem(
        product: products[index],
      );
    },
  );
}

Row _buildLabel() {
  return Row(
    children: const [
      Expanded(
        child: Text(
          'Popular Products',
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
          color: Colors.lightGreen,
        ),
      ),
    ],
  );
}

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  dynamic product;
  ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, productRoute,
            arguments: ProductDetailsArguments(productId: product["_id"]));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image:
                  NetworkImage(ApiServices().apiEndpoint + product['image'][0]),
              fit: BoxFit.fill,
            ),
            Expanded(child: _buildProductInfo())
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND', decimalDigits: 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 130,
            child: Text(
              product['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(2.0),
            color: Colors.green,
          ),
          child: Text(
            formatCurrency.format(product['price']),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
