import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StatusDatabase {
  final String uid;
  StatusDatabase({this.uid});

  String date = DateFormat('dd/MM/yyyy - kk:mm').format(
    DateTime.now(),
  );

  final CollectionReference statusCollection =
      FirebaseFirestore.instance.collection('Status');

  Future setStatus() async {
    return await statusCollection.doc('1').set({});
  }

  Future updateUserStatus(int roomNumber) async {
    await statusCollection.doc(uid).set({
      'Status': 'Order received',
      'Room Number': roomNumber,
      'User Id': uid,
      'Time': 'Ordered at $date',
    });
  }
}
