import 'package:ebutler/Screens/Home/history_screen.dart';
import 'package:ebutler/Screens/Home/home.dart';
import 'package:ebutler/Screens/Home/information.dart';
import 'package:ebutler/Screens/Home/order_screen.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  int currentIndex = 0;
  BottomNavBar(currentIndex, {Key key}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // int _currentIndex = 0;

  final List<Widget> _children = [
    const Home(),
    const Information(),
    const HistoryScreen(),
    const OrderScreen(),
  ];

  void onTapTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: _children[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapTapped,
        currentIndex: widget.currentIndex,
        elevation: kLess,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kLightColor,
        backgroundColor: kWhiteColor,
        // showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Information',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Order',
          ),
        ],
      ),
    );
  }
}
