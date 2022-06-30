import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Screens/Home/home.dart';
import 'package:ebutler/Services/statusdatabase.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key key}) : super(key: key);
  static const routeName = 'NotificationList';
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
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
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    String uid = user.uid;
    String finishOrderedTime = DateFormat('kk:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(color: kYellowColor),
        ),
        leading: const BackButton(
          color: kYellowColor,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Status')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Notification!'),
            );
          } else {
            if (snapshot.data['Status'] == "Order is on the way" &&
                switchName == 'RST') {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Card(
                    elevation: 8,
                    shadowColor: Colors.orange,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 1),
                    ),
                    child: ListTile(
                      leading: Text(
                        snapshot.data['Room Number'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                      title: Text(snapshot.data['Status'].toString()),
                      subtitle: Text(snapshot.data['Time'].toString() +
                          " - " +
                          finishOrderedTime),
                      trailing: Text(
                        snapshot.data['Date'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            }

            if (snapshot.data['Status'] == "Order is finished") {
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Card(
                    color: Colors.grey[400],
                    elevation: 8,
                    shadowColor: Colors.orange,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.orange, width: 1),
                    ),
                    child: ListTile(
                      leading: Text(
                        snapshot.data['Room Number'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                      title: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: snapshot.data['Status'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        WidgetSpan(
                            child: Icon(Icons.verified, color: Colors.green))
                      ])),
                      subtitle: Text(snapshot.data['Time'].toString() +
                          " - " +
                          finishOrderedTime),
                      trailing: Text(
                        snapshot.data['Date'].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Card(
                  elevation: 8,
                  shadowColor: Colors.orange,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 1),
                  ),
                  child: ListTile(
                    leading: Text(
                      snapshot.data['Room Number'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                    title: Text(
                      snapshot.data['Status'].toString(),
                    ),
                    subtitle: Text(snapshot.data['Time'].toString()),
                    trailing: Text(
                      snapshot.data['Date'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          }

          //     if (switchName == 'RST') {
          //       showNotification();
          //     }
          //     // while (switchName != "RST") {
          //     //   readDatabase();

          //     //   if (switchName == "RST") {
          //     //     showNotification();
          //     //     break;
          //     //   }
          //     // }
          //     //   showNotification();
          //     //   if (snapshot.data['Status'] == "Order is on the way" &&
          //     //       switchName == "RST") {
          //     //     return ListView(
          //     //       scrollDirection: Axis.vertical,
          //     //       children: [
          //     //         Card(
          //     //           elevation: 8,
          //     //           shadowColor: Colors.orange,
          //     //           shape: OutlineInputBorder(
          //     //             borderRadius: BorderRadius.circular(10),
          //     //             borderSide:
          //     //                 const BorderSide(color: Colors.orange, width: 1),
          //     //           ),
          //     //           child: ListTile(
          //     //             leading: Text(
          //     //               snapshot.data['Room Number'].toString(),
          //     //               style: const TextStyle(
          //     //                   fontWeight: FontWeight.bold,
          //     //                   fontSize: 20,
          //     //                   color: Colors.purple),
          //     //             ),
          //     //             title: Text(snapshot.data['Status'].toString()),
          //     //             subtitle: Text(snapshot.data['Time'].toString() +
          //     //                 " - " +
          //     //                 finishOrderedTime),
          //     //             trailing: Text(
          //     //               snapshot.data['Date'].toString(),
          //     //               style: const TextStyle(fontWeight: FontWeight.bold),
          //     //             ),
          //     //           ),
          //     //         ),
          //     //       ],
          //     //     );
          //     //   }
          //     // } while (switchName == "RST");

          // return ListView(
          //   scrollDirection: Axis.vertical,
          //   children: [
          //     Card(
          //       elevation: 8,
          //       shadowColor: Colors.orange,
          //       shape: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //         borderSide: const BorderSide(color: Colors.orange, width: 1),
          //       ),
          //       child: ListTile(
          //         leading: Text(
          //           snapshot.data['Room Number'].toString(),
          //           style: const TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 20,
          //               color: Colors.purple),
          //         ),
          //         title: Text(
          //           snapshot.data['Status'].toString(),
          //         ),
          //         subtitle: Text(snapshot.data['Time'].toString()),
          //         trailing: Text(
          //           snapshot.data['Date'].toString(),
          //           style: const TextStyle(fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //     ),
          //   ],
          // );
        },
      ),
      // body: StreamBuilder<DocumentSnapshot>(
      //     stream: FirebaseFirestore.instance
      //         .collection("Status")
      //         .doc(uid)
      //         .snapshots(),
      //     builder: (BuildContext context,
      //         AsyncSnapshot<DocumentSnapshot> snapshotStatus) {
      //       if (!snapshotStatus.hasData) {
      //         return Center(
      //           child: Text('Kosong'),
      //         );
      //       }
      //       newDate = null;
      //       time = '';
      //       Status = '';
      //       roomNumber = null;

      //       return Container(
      //         padding: const EdgeInsets.only(top: 10),
      //         child: Text(
      //           snapshotStatus.data['Status'] ?? 'no',
      //           style:
      //               const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      //         ),
      //       );
      //     }),
    );
  }
}
