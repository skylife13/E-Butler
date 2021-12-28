import 'package:ebutler/Screens/Home/home.dart';
import 'package:ebutler/Screens/Home/product_detail_screen.dart';
import 'package:ebutler/Screens/Home/products_overview_screen.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';

class ShopBackButton extends StatelessWidget {
  const ShopBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
      onPressed: () => Navigator.of(context).pushNamed('/'),
    );
  }
}
