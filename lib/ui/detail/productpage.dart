import 'package:flutter/material.dart';
import '../../services/ApiServices.dart';
import 'components/body.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  dynamic productDetail;
  late String productId;
  bool _isFetchingData = false;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    productId = arguments.productId;
    _fetchProductDetail();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Details"),
      ),
      body: productDetail == null
          ? const CircularProgressIndicator()
          : Body(productDetail: productDetail),
    );
  }

  Future<void> _fetchProductDetail() async {
    if (!_isFetchingData) {
      _isFetchingData = true;
      try {
        final products = await ApiServices().getProductDetail(productId);
        if (products['success']) {
          setState(() {
            productDetail = products['data']['data'];
          });
        } else {
          // handle error
        }
      } catch (e) {
        // handle exception
      }
    }
  }
}

class ProductDetailsArguments {
  dynamic productId;
  ProductDetailsArguments({required this.productId});
}
