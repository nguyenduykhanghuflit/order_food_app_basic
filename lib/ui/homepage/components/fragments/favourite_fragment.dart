import 'package:flutter/material.dart';

import '../../../../models/products.dart';

// ignore: must_be_immutable
class FavouriteDetail extends StatelessWidget {
  List<Products> products;
  FavouriteDetail(this.products, {super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(products.length.toString());
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItemList(
            product: products[index],
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductItemList extends StatelessWidget {
  Products product;
  ProductItemList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _buildThumbnail(),
          const SizedBox(width: 5.0),
          _buildProductInfo(),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Expanded(
      child: SizedBox(
        height: 100.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.title),
            Expanded(
              child: Text(
                product.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Image(
        image: AssetImage(product.image),
        fit: BoxFit.fill,
      ),
    );
  }
}
