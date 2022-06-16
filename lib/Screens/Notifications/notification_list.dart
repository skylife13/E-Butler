import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Screens/Notifications/notification_page.dart';
import 'package:ebutler/Shared/constants.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'components/notification_tiles.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key key}) : super(key: key);
  static const routeName = 'NotificationList';
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    String uid = user.uid;
    String Status;
    Timestamp newTime;
    DateTime newDate;
    String time;
    int roomNumber;

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
              .collection("Status")
              .doc(uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshotStatus) {
            if (!snapshotStatus.hasData) {
              return Center(
                child: Text('Kosong'),
              );
            }
            newDate = null;
            time = '';
            Status = '';
            roomNumber = null;

            return Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                snapshotStatus.data['Status'] ?? 'no',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            );
          }),
    );
  }
}
