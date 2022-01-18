import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StatusDatabase {
  final String uid;
  StatusDatabase({this.uid});

  String date = DateFormat('dd/MM/yyyy - kk:mm').format(
    DateTime.now(),
  );

  final CollectionReference statusCollection =
      Firestore.instance.collection('Status');

  Future setStatus() async {
    return await statusCollection.document('1').setData({});
  }

  Future updateUserStatus(int roomNumber) async {
    await statusCollection.document(uid).setData({
      'Status': 'Order received',
      'Room Number': roomNumber,
      'User Id': uid,
      'Time': 'Ordered at $date',
    });
  }
}
