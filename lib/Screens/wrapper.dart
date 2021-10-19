import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Screens/Authenticate/authenticate.dart';

import 'package:ebutler/Screens/Home/products_overview_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // print(user);
    //return either Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return const ProductsOverviewScreen();
    }
  }
}
