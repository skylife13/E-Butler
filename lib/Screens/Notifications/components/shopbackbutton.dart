import 'package:ebutler/Screens/Home/home.dart';
import 'package:ebutler/Screens/Home/product_detail_screen.dart';
import 'package:ebutler/Screens/Home/products_overview_screen.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopBackButton extends StatelessWidget {
  const ShopBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    Future<bool> showExitPopup() async {
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
                    Navigator.of(context).pushNamed('/');
                    cart.clear();
                  },
                  //return true when click on "Yes"
                  child: Text('Yes, clear cart'),
                ),
              ],
            ),
          ) ??
          () => Navigator.of(context).pop(true);

      //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
        onPressed: () => cart.itemCount > 0 ? () => showExitPopup() : null,
      ),
    );
  }
}
