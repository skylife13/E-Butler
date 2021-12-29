import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Screens/Notifications/components/default_appbar.dart';
import 'package:ebutler/Screens/Notifications/components/default_backbutton.dart';
import 'package:intl/intl.dart';

import '/Model/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);
  static const routeName = 'historyScreen';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

//Masih ga optimal soalnya kalo tiap detik beda document, karena loop butuh
//waktu milisecond, kalau user pesen misal tepat 1ms sblm pindah detik
//nanti document kebikin jadi 2x
class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    String uid = user.uid;

    Timestamp newTime;
    DateTime newDate;
    String time;
    int roomNumber;

    var streamSnapshot = Firestore.instance.collection(uid).snapshots();
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'History',
        child: DefaultBackButton(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: streamSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Kosong'),
            );
          }
          newDate = null;
          time = '';
          roomNumber = null;
          return ListView(
            children: snapshot.data.documents.map(
              (doc) {
                for (var i in doc.data.values) {
                  roomNumber = i['Room Number'];
                  newTime = i['Time'];
                  newDate = newTime.toDate();
                  time = DateFormat('dd/MM/yyyy - kk:mm:ss').format(newDate);
                  break;
                }
                return Column(
                  children: [
                    for (var i in doc.data.values)
                      Text(
                        i['Item'].toString(),
                      ),
                    Text(roomNumber.toString()),
                    Text(time),
                  ],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
