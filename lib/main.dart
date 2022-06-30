import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Screens/Home/history_screen.dart';
import 'package:ebutler/Screens/Home/information.dart';
import 'package:ebutler/Screens/Home/myprofile_screen.dart';
import 'package:ebutler/Screens/Home/payment_screen.dart';
import 'package:ebutler/Screens/Home/scheduled_screen.dart';
import 'package:ebutler/Screens/Home/status_screen.dart';
import 'package:ebutler/Screens/Notifications/notification_list.dart';
import 'package:ebutler/Services/statusdatabase.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '/Screens/wrapper.dart';
import '/Services/auth.dart';
import '/Model/user.dart';
import '/Screens/Home/product_detail_screen.dart';
import '/Screens/Home/cart_screen.dart';
import '/providers/products.dart';
import '/providers/cart.dart';
import '/providers/orders.dart';
import 'Screens/Home/products_overview_screen.dart';
import 'Screens/Home/history_screen.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // //REAL TIME DATABASE//
  // final DatabaseReference ref = FirebaseDatabase(
  //         databaseURL:
  //             "https://e-butlerdb-default-rtdb.asia-southeast1.firebasedatabase.app")
  //     .reference();
  // String switchName = '';
  // StreamSubscription databaseStream;

  // readDatabase() {
  //   databaseStream = ref.child('Arduino/Switch').onValue.listen((event) {
  //     setState(() {
  //       switchName = event.snapshot.value.toString();
  //     });
  //   });
  // }
  // //-------------------------------------------------------------------//

  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  //   databaseStream.cancel();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   readDatabase();
  // }

  // //function for show notification when 'Switch' == 'RST'//
  // showNotification() {
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       'BINUS Hotel',
  //       'Order has arrived.',
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               channel.id, channel.name, channel.description,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher')));
  // }

  @override
  Widget build(BuildContext context) {
    // final User user = FirebaseAuth.instance;
    // String test = AuthService().user.toString();
    // if (switchName == 'RST') {
    //   print(uid);
    //   showNotification();
    // }
    return StreamProvider<UserModel>.value(
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
                accentColor: kWhiteColor,
                fontFamily: 'Lato',
              ),
              home: const Wrapper(),
              routes: {
                ProductsOverviewScreen.routeName: (ctx) =>
                    const ProductsOverviewScreen(),
                ProductDetailScreen.routeName: (ctx) =>
                    const ProductDetailScreen(),
                CartScreen.routeName: (ctx) => const CartScreen(),
                Information.routeName: (ctx) => const Information(),
                HistoryScreen.routeName: (ctx) => const HistoryScreen(),
                PaymentScreen.routeName: (ctx) => const PaymentScreen(),
                StatusScreen.routeName: (ctx) => const StatusScreen(),
                ScheduledScreen.routeName: (ctx) => const ScheduledScreen(),
                MyProfile.routeName: (ctx) => const MyProfile(),
                NotificationList.routeName: (ctx) => const NotificationList(),
              })),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<User>.value(
//       initialData: null,
//       value: AuthService().user,
//       child: MultiProvider(
//         providers: [
//           ChangeNotifierProvider(
//             create: (ctx) => Products(),
//           ),
//           ChangeNotifierProvider(
//             create: (ctx) => Cart(),
//           ),
//           ChangeNotifierProvider(
//             create: (ctx) => Orders(),
//           ),
//         ],
//         child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               primarySwatch: kPrimaryColor,
//               accentColor: kWhiteColor,
//               fontFamily: 'Lato',
//             ),
//             home: const Wrapper(),
//             routes: {
//               ProductsOverviewScreen.routeName: (ctx) =>
//                   const ProductsOverviewScreen(),
//               ProductDetailScreen.routeName: (ctx) =>
//                   const ProductDetailScreen(),
//               CartScreen.routeName: (ctx) => const CartScreen(),
//               Information.routeName: (ctx) => const Information(),
//               HistoryScreen.routeName: (ctx) => const HistoryScreen(),
//               PaymentScreen.routeName: (ctx) => const PaymentScreen(),
//               StatusScreen.routeName: (ctx) => const StatusScreen(),
//               ScheduledScreen.routeName: (ctx) => const ScheduledScreen(),
//               MyProfile.routeName: (ctx) => const MyProfile(),
//               NotificationList.routeName: (ctx) => const NotificationList(),
//             }),
//       ),
//     );
//   }
// }