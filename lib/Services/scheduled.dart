import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Scheduled {
  final String uid;
  Scheduled({this.uid});

  DateTime dateTime = DateTime.now();
  String newTime;

  final CollectionReference scheduledCartCollection =
      FirebaseFirestore.instance.collection('Scheduled Cart');

  Future setUserData() async {
    return await scheduledCartCollection.doc('1').set({});
  }

  Future updateUserCart(
    int roomNumber,
    int index,
    String id,
    int amount,
    String title,
    int total,
    int price,
    int quantity,
    String time,
  ) async {
    newTime = DateFormat('dd:MM:yy kk:mm:ss').format(dateTime);

    Map<String, Object> products = {
      'User Id': uid,
      'Room Number': roomNumber,
      'Item Id': id,
      'Title': title,
      'Price': price,
      'Quantity': quantity,
      'Total': total,
      'Total Price': amount,
      'Time': time,
      'Time Ordered': newTime,
    };
    await scheduledCartCollection
        .doc(uid)
        .set({'$index': products}, SetOptions(merge: true));
  }
}
