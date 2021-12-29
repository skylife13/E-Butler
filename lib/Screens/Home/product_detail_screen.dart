import 'package:ebutler/Screens/Notifications/components/default_appbar.dart';

import 'package:ebutler/Screens/Notifications/components/default_backbutton2.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/cart.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/products.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({
    Key key,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    final _formKey = GlobalKey<FormState>();

    final cart = Provider.of<Cart>(context, listen: false);

    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: DefaultAppBar(
        title: loadedProduct.title,
        child: DefaultBackButton2(),
        action: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: kPrimaryColor),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text(
              'Logout',
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(children: <Widget>[
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
                          loadedProduct.quantity.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cart.removeSingleItem(
                        loadedProduct.id); //ganti jadi remove item
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: loadedProduct.quantity != 0
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

                    if (loadedProduct.quantity < 1) {
                      loadedProduct.quantity = 0;
                    } else {
                      loadedProduct.quantity -= 1;
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

                    loadedProduct.quantity += 1;
                  },
                  color: Theme.of(context).accentColor,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
