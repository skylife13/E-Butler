import 'package:flutter/material.dart';

const MaterialColor kPrimaryColor = MaterialColor(
  0xFFFF8084,
  <int, Color>{
    50: Color(0xFFFF8084),
    100: Color(0xFFFF8084),
    200: Color(0xFFFF8084),
    300: Color(0xFFFF8084),
    400: Color(0xFFFF8084),
    500: Color(0xFFFF8084),
    600: Color(0xFFFF8084),
    700: Color(0xFFFF8084),
    800: Color(0xFFFF8084),
    900: Color(0xFFFF8084),
  },
);
const MaterialColor kAccentColor = MaterialColor(
  0xFFF1F1F1,
  <int, Color>{
    50: Color(0xFFF1F1F1),
    100: Color(0xFFF1F1F1),
    200: Color(0xFFF1F1F1),
    300: Color(0xFFF1F1F1),
    400: Color(0xFFF1F1F1),
    500: Color(0xFFF1F1F1),
    600: Color(0xFFF1F1F1),
    700: Color(0xFFF1F1F1),
    800: Color(0xFFF1F1F1),
    900: Color(0xFFF1F1F1),
  },
);

const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kWhiteColor, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
  ),
);
const String logo =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSIQEAJNH8zuwKGVT0jI7i_xRHaaIwMeEHTw&usqp=CAU';

final menuLabel = ['Home', 'Information', 'History', 'Shop'];
final menuIcons = [Icons.home, Icons.book, Icons.book, Icons.shop];
