import 'package:flutter/material.dart';

const MaterialColor kPrimaryColor = MaterialColor(
  0xFF432344,
  <int, Color>{
    50: Color(0xFF432344),
    100: Color(0xFF432344),
    200: Color(0xFF432344),
    300: Color(0xFF432344),
    400: Color(0xFF432344),
    500: Color(0xFF432344),
    600: Color(0xFF432344),
    700: Color(0xFF432344),
    800: Color(0xFF432344),
    900: Color(0xFF432344),
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
const kYellowColor = Color(0xFFFFC03D);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFFE7EEFB);
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

final menuLabel = ['Amenities', 'Information'];
final menuIcons = [Icons.shop, Icons.book];
final accountLabel = ['History', 'Scheduled Order'];
final accountIcons = [Icons.book, Icons.schedule];
