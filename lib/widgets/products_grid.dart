import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  // final bool showFavs;

  // const ProductsGrid(this.showFavs, {Key key}) : super(key: key);
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
        //create: (c) => products[i],
        //use value constructor in this scenario
        value: products[i],
        child: const ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
    );
  }
}
