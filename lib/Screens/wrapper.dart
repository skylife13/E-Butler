import 'package:flutter/material.dart';

import '/Model/user.dart';
import '/Screens/Authenticate/authenticate.dart';
import '/Screens/Home/products_overview_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return const ProductsOverviewScreen();
    }
  }
}
