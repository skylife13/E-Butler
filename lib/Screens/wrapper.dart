import 'package:ebutler/Screens/Home/bottom_navbar.dart';
import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Screens/Authenticate/authenticate.dart';
import '/Screens/Home/products_overview_screen.dart';
import 'package:provider/provider.dart';
import '/providers/product.dart';
import '/Services/productdatabase.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return BottomNavBar(0);
      // return StreamProvider<List<Product>>.value(
      //   child: const ProductsOverviewScreen(),
      //   value: ProductDatabase().productsStream,
      //   initialData: [],
      // );
    }
  }
}
