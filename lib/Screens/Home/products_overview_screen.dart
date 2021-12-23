import 'package:ebutler/Screens/Notifications/components/default_backbutton.dart';
import 'package:ebutler/Services/productdatabase.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/Services/auth.dart';
import '/widgets/products_grid.dart';
import '/providers/cart.dart';
import '/Screens/Home/cart_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/badge.dart';
import '/Model/user.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key key}) : super(key: key);
  static const routeName = '/ProductOverviewScreen';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
      initialData: [],
      value: ProductDatabase().productsStream,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MyShop',
            style: TextStyle(color: kPrimaryColor),
          ),
          backgroundColor: kWhiteColor,
          leading: DefaultBackButton(),
          actions: <Widget>[
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
            Consumer<Cart>(
                builder: (_, cart, ch) => Badge(
                      child: ch,
                      value: cart.itemCount.toString(),
                    ),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart, color: kPrimaryColor),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ))
          ],
        ),
        drawer: const AppDrawer(),
        body: ProductsGrid(),
      ),
    );
  }
}
