import 'dart:convert';
import 'package:quiver/strings.dart';

import 'package:http/http.dart' as http;

import '../models/products.dart';

class Utilities {
  String url = 'http://172.20.250.228:3000/api/food';

  static List<Products> data = [];

  Future<List<Products>> getProducts() async {
    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var content = res.body;
      // ignore: avoid_print
      print(content.toString());
      var arr = json.decode(content)['food'] as List;

      return arr.map((e) => _fromJson(e)).toList();
    } else {}
    return <Products>[];
  }

  Products _fromJson(Map<String, dynamic> item) {
    return Products(
        title: item['title'],
        description: item['description'],
        image: item['image'],
        price: double.parse(item['price']));
  }

  static String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter mail';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern as String);
    if (!regExp.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return '';
    }
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password should be more than 8 characters';
    } else {
      return '';
    }
  }

  static String conformPassword(String value, String value2) {
    if (!equalsIgnoreCase(value, value2)) {
      return 'Conform password invalid';
    } else {
      return 'Please enter password';
    }
  }

  Future<List<Products>> find(String value) async {
    List<Products> products = await getProducts();
    return products.where((element) => element.title.contains(value)).toList();
  }

  //Iterable<Products> find(String title) {}
  /*
  static bool equalsIgnoreCase(String value, String value2) {
    if (value == value2) {
      return true;
    } else {
      return false;
    }
  }
  */
}
