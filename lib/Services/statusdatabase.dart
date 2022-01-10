import 'package:cloud_firestore/cloud_firestore.dart';

class StatusDatabase {
  final String uid;
  StatusDatabase({this.uid});

  final CollectionReference statusCollection =
      Firestore.instance.collection('Status');

  Future setStatus() async {
    return await statusCollection.document('1').setData({});
  }

  Future updateUserStatus(int roomNumber) async {
    await statusCollection.document(uid).setData({
      'Status': 'Order received',
      'Room Number': roomNumber,
      'User Id': uid
    });
  }
}
