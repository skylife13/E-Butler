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
    Future<bool> showExitPopup() async {
      final cart = Provider.of<Cart>(context, listen: false);
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('You Still have items in cart'),
              content: Text('Do you want to go back?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text("'No,i'll stay"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    cart.clear();
                  },
                  //return true when click on "Yes"
                  child: Text('Yes, clear cart'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return StreamProvider<List<Product>>.value(
      initialData: [],
      value: ProductDatabase().productsStream,
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'MyShop',
              style: TextStyle(color: kPrimaryColor),
            ),
            backgroundColor: kWhiteColor,
            // leading: DefaultBackButton(),
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
          // drawer: const AppDrawer(),
          body: ProductsGrid(),
        ),
      ),
    );
  }
}
