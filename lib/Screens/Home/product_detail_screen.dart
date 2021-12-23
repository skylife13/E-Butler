import 'package:ebutler/Screens/Home/cart_screen.dart';
import 'package:ebutler/providers/cart.dart';
import 'package:ebutler/providers/product.dart';
import 'package:ebutler/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    final cart = Provider.of<Cart>(context, listen: false);

    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
        actions: <Widget>[
          Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                    child: ch,
                    value: cart.itemCount.toString(),
                  ),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Rp. ${loadedProduct.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            GridTileBar(
              backgroundColor: Colors.black54,
              title: Consumer<Cart>(
                builder: (_, cart, child) => Stack(
                  children: [
                    Center(
                      child: Text(
                        quantity.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                'Rp.${loadedProduct.price}',
              ),
              leading: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  cart.removeSingleItem(
                      loadedProduct.id); //ganti jadi remove item
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: quantity != 0
                          ? const Text(
                              'Removed Item From Cart',
                              textAlign: TextAlign.center,
                            )
                          : const Text(
                              'Add Item First',
                              textAlign: TextAlign.center,
                            ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  if (quantity < 1) {
                    quantity = 0;
                  } else {
                    quantity -= 1;
                  }
                },
                color: Theme.of(context).accentColor,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.add,
                ),
                onPressed: () {
                  cart.addItem(loadedProduct.id, loadedProduct.price,
                      loadedProduct.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Added item to cart!',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  quantity += 1;
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
