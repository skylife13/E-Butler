import 'package:cloud_firestore/cloud_firestore.dart';

class Scheduled {
  final String uid;
  Scheduled({this.uid});

  final CollectionReference scheduledCartCollection =
      Firestore.instance.collection('Scheduled Cart');

  Future setUserData() async {
    return await scheduledCartCollection.document('1').setData({});
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
    Map<String, Object> products = {
      'User Id': uid,
      'Room Number': roomNumber,
      'Item Id': id,
      'Title': title,
      'Price': price,
      'Quantity': quantity,
      'Total': total,
      'Total Price': amount,
      'Time': time
    };
    await scheduledCartCollection
        .document(uid)
        .setData({'$index': products}, merge: true);
  }
}
