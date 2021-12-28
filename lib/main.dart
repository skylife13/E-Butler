import 'package:ebutler/Screens/Home/history_screen.dart';
import 'package:ebutler/Screens/Home/information.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/Screens/wrapper.dart';
import '/Services/auth.dart';
import '/Model/user.dart';
import '/Screens/Home/product_detail_screen.dart';
import '/Screens/Home/cart_screen.dart';
import '/Screens/Home/order_screen.dart';
import '/providers/products.dart';
import '/providers/cart.dart';
import '/providers/orders.dart';
import 'Screens/Home/products_overview_screen.dart';
import 'Screens/Home/history_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Products(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: kPrimaryColor,
              accentColor: Colors.white,
              fontFamily: 'Lato',
            ),
            home: const Wrapper(),
            routes: {
              ProductsOverviewScreen.routeName: (ctx) =>
                  const ProductsOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrderScreen.routeName: (ctx) => const OrderScreen(),
              Information.routeName: (ctx) => const Information(),
              HistoryScreen.routeName: (ctx) => const HistoryScreen(),
            }),
      ),
    );
  }
}
