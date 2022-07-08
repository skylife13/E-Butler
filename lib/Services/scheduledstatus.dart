import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ScheduledStatus {
  final String uid;
  ScheduledStatus({this.uid});

  String timeOrder = DateFormat('kk:mm').format(
    DateTime.now(),
  );

  final CollectionReference scheduledStatusCollection =
      FirebaseFirestore.instance.collection('Scheduled Status');

  Future setStatus() async {
    return await scheduledStatusCollection.doc('1').set({});
  }

  Future updateUserStatus(int roomNumber, String time) async {
    await scheduledStatusCollection.doc(uid).set({
      'Status': 'Scheduled for $time',
      'Time': timeOrder,
      'Room Number': roomNumber,
      'User Id': uid
    });
  }
}
