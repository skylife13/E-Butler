import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class StatusDatabase {
  final String uid;
  StatusDatabase({this.uid});

  String date = DateFormat('dd/MM/yyyy').format(
    DateTime.now(),
  );
  String time = DateFormat('kk:mm').format(
    DateTime.now(),
  );

  int index = 0;

  final CollectionReference statusCollection =
      FirebaseFirestore.instance.collection('Status');

  DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              "https://e-butlerdb-default-rtdb.asia-southeast1.firebasedatabase.app")
      .reference();
  String switchName = '';
  StreamSubscription databaseStream;

  Future setStatus() async {
    return await statusCollection.doc('1').set({});
  }

  Future updateUserStatus(int roomNumber) async {
    await statusCollection.doc(uid).set({
      'Status': 'Order received',
      'Room Number': roomNumber,
      'User Id': uid,
      'Date': 'Ordered at $date',
      'Time': '$time'
    });
  }

  void readDatabase() {
    databaseStream = ref.child('Arduino/Switch').onValue.listen((event) {
      switchName = event.snapshot.value.toString();
    });
  }
}
