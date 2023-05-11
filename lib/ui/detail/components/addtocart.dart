import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/ApiServices.dart';
import '../../dialog/show_dialog.dart';

// ignore: must_be_immutable
class AddProductToCart extends StatefulWidget {
  dynamic product;
  AddProductToCart({super.key, required this.product});
  @override
  // ignore: library_private_types_in_public_api
  _AddProductToCartState createState() => _AddProductToCartState();
}

class _AddProductToCartState extends State<AddProductToCart> {
  int qty = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleAddCart(productId, amount) async {
    dynamic res = await ApiServices().addToCart(productId, amount);

    if (res['success']) {
      Fluttertoast.showToast(
          msg: "Added 1 product to the cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            message: res['message'],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuantitySelector(
          initialValue: 1,
          onChanged: (quantity) {
            setState(() {
              qty = quantity;
            });
          },
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              //handle add cart
              dynamic productId = widget.product['_id'];
              handleAddCart(productId, qty);
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text(
              "Add to cart",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final void Function(int quantity) onChanged;

  const QuantitySelector({
    Key? key,
    this.initialValue = 1,
    required this.onChanged,
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _quantity++;
      widget.onChanged(_quantity);
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        widget.onChanged(_quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _decrement,
          icon: Icon(Icons.remove),
        ),
        SizedBox(
          width: 40,
          child: Text(
            _quantity.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: _increment,
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
