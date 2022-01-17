import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduledStatus {
  final String uid;
  ScheduledStatus({this.uid});

  final CollectionReference scheduledStatusCollection =
      Firestore.instance.collection('Scheduled Status');

  Future setStatus() async {
    return await scheduledStatusCollection.document('1').setData({});
  }

  Future updateUserStatus(int roomNumber, String time) async {
    await scheduledStatusCollection.document(uid).setData({
      'Status': 'Scheduled for $time',
      'Room Number': roomNumber,
      'User Id': uid
    });
  }
}
