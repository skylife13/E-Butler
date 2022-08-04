import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/product.dart';
import '/providers/cart.dart';
import '/Screens/Home/product_detail_screen.dart';
import 'badge.dart';

class ProductItem extends StatelessWidget {
  ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        header: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
        ),
        child: Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: ch,
            value: 'Quantity: ' + product.quantity.toString() + 'x',
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
