import 'package:ebutler/Screens/Home/cart_screen.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/cart.dart';
import 'package:ebutler/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final action;
  const DefaultAppBar2({
    Key key,
    this.title,
    this.child,
    this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return AppBar(
        title: Text(title, style: TextStyle(color: kPrimaryColor)),
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: kRadius,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: child,
        actions: <Widget>[
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
        ]);
  }
}
