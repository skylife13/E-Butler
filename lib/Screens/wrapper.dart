import 'dart:async';
import 'package:ebutler/Screens/Home/bottom_navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/Model/user.dart';
import '/Screens/Authenticate/authenticate.dart';
import 'package:provider/provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  //REAL TIME DATABASE//
  final DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              "https://e-butlerdb-default-rtdb.asia-southeast1.firebasedatabase.app")
      .reference();
  String switchName = '';
  StreamSubscription databaseStream;

  readDatabase() {
    databaseStream = ref.child('Arduino/Switch').onValue.listen((event) {
      setState(() {
        switchName = event.snapshot.value.toString();
      });
    });
  }

  //-------------------------------------------------------------------//
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    databaseStream.cancel();
  }

  @override
  void initState() {
    super.initState();
    readDatabase();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  //function for show notification when 'Switch' == 'RST'//
  showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        'BINUS Hotel',
        'Order has arrived.',
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      if (switchName == 'RST') {
        showNotification();
      }
      return BottomNavBar(0);
    }
  }
}
