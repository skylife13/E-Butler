import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: const ProductItem(),
      ),
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
    );
  }
}
