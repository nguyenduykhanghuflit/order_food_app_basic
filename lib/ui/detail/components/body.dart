import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_food_v1/services/ApiServices.dart';
import 'package:order_food_v1/ui/detail/components/addtocart.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  dynamic productDetail;
  Body({super.key, required this.productDetail});
  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND', decimalDigits: 0);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 500,
            height: 300,
            child: Image.network(
              ApiServices().apiEndpoint + productDetail["image"][0],
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: Text(
              'Tên sản phẩm: ${productDetail['name']}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 500,
            child: Text(
              'Description: ${productDetail['description']}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.green,
            ),
            child: Text(
              formatCurrency.format(productDetail['price']),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox(height: 50)),
          AddProductToCart(
            product: productDetail,
          )
        ],
      ),
    );
  }
}
