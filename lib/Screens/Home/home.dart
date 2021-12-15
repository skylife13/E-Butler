import 'package:ebutler/Screens/Home/products_overview_screen.dart';
import 'package:ebutler/Screens/Notifications/notification_list.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/widgets/sticky_label.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('BINUS Hotel'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: kWhiteColor),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NotificationList(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const StickyLabel(text: "Menu"),
            Container(
              height: 220.0,
              padding: const EdgeInsets.only(top: 14.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                ),
                itemCount: menuLabel.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      IconButton(
                          icon: Icon(menuIcons[index],
                              color: kPrimaryColor, size: 34.0),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(ProductsOverviewScreen.routeName)),
                      Text(
                        menuLabel[index],
                        style:
                            const TextStyle(color: kLightColor, fontSize: 10),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
