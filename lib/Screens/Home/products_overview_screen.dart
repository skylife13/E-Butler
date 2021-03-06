import 'package:ebutler/Screens/Notifications/components/default_backbutton.dart';
import 'package:ebutler/Screens/Notifications/components/shopbackbutton.dart';
import 'package:ebutler/Services/productdatabase.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/Services/auth.dart';
import '/widgets/products_grid.dart';
import '/providers/cart.dart';
import '/Screens/Home/cart_screen.dart';
import '/widgets/badge.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key key}) : super(key: key);
  static const routeName = '/ProductOverviewScreen';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options

            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit'),
              content: const Text(
                  'Are you sure you want to exit? the items in the cart will be lost'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text("No,i'll stay",
                      style: TextStyle(color: kYellowColor)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                    cart.clear();
                  },
                  //return true when click on "Yes"
                  child:
                      const Text('Yes', style: TextStyle(color: kYellowColor)),
                ),
              ],
            ),
          ) ??
          () => Navigator.of(context).pop(true);

      //if showDialouge had returned null, then return false
    }

    Future<bool> showExitPopupzero() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options

            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit'),
              content:
                  const Text('If you choose yes then the cart will be cleared'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text("No,i'll stay"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          () => Navigator.of(context).pop(true);

      //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: StreamProvider<List<Product>>.value(
        initialData: [],
        value: ProductDatabase().productsStream,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Amenities',
              style: TextStyle(color: kYellowColor),
            ),
            leading: const BackButton(
              color: kYellowColor,
            ),
            backgroundColor: kPrimaryColor,

            // leading: const ShopBackButton(),
            actions: <Widget>[
              Consumer<Cart>(
                  builder: (_, cart, ch) => Badge(
                        child: ch,
                        value: cart.itemCount.toString(),
                      ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart, color: kYellowColor),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                  ))
            ],
          ),
          // drawer: const AppDrawer(),
          body: const ProductsGrid(),
        ),
      ),

      // onWillPop: cart.itemCount > 0
      //     ? () => showExitPopup()
      //     : () => showExitPopupzero(),
    );
  }
}
