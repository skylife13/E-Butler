import 'package:ebutler/Screens/Home/home.dart';
import 'package:ebutler/Screens/Home/product_detail_screen.dart';
import 'package:ebutler/Screens/Home/products_overview_screen.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';

class DefaultBackButton2 extends StatelessWidget {
  const DefaultBackButton2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
      onPressed: () => Navigator.of(context).pop(context),
    );
  }
}
