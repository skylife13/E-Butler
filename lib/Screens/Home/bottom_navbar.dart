import 'package:ebutler/Screens/Home/home.dart';
import 'package:ebutler/Screens/Home/myprofile_screen.dart';
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

    const MyProfile()
    // const OrderScreen(),
  ];

  void onTapTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapTapped,
        currentIndex: widget.currentIndex,
        elevation: kLess,
        selectedItemColor: kYellowColor,
        unselectedItemColor: kLightColor,
        backgroundColor: kPrimaryColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
