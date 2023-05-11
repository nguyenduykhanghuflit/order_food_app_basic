import 'package:flutter/material.dart';
import 'package:order_food_v1/ui/homepage/components/fragments/favourite_fragment.dart';

import 'package:order_food_v1/models/products.dart';
import 'package:order_food_v1/utilities/utilities.dart';
import 'package:flutter_tags/flutter_tags.dart';

class Body extends StatefulWidget {
  List<Products> dataProduct = [];
// Body({this.dataProduct});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _tags = [];
  List<Products> products = Products.init();
  List<Products> productsResult = [];

  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tags.addAll(['food', 'categories', 'bread']);
    textEditingController = TextEditingController();
  }

/*
  Widget buildTag(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recommend'),
          const SizedBox(
            height: 10,
          ),
          Tags(
            itemCount: _tags.length,
            itemBuilder: (index) {
              // print(index.toString());
              return ItemTags(
                index: index,
                title: _tags[index],
                onPressed: (item) {
                  setState(() {
                    widget.dataProduct.clear();
                    widget.dataProduct.addAll();
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: buildRow(),
        ),
        body: buildContainer(context));
  }

  Widget buildRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search product",
                prefixIcon: Icon(Icons.search)),
            onChanged: (value) async {
              if (value.isEmpty) {
                setState(() {
                  widget.dataProduct = [];
                });
                return;
              }
              List<Products> products = await Utilities().find(value);
              setState(() {
                widget.dataProduct.clear();
                widget.dataProduct.addAll(products);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //buildTag(context),
          if (widget.dataProduct.isEmpty)
            const Expanded(child: Center(child: Text('No item')))
          else
            Expanded(
                child: ListView.builder(
                    itemCount: widget.dataProduct.length,
                    itemBuilder: (context, index) {
                      return ProductItemList(
                        product: widget.dataProduct[index],
                      );
                    }))
        ],
      ),
    );
  }
}
