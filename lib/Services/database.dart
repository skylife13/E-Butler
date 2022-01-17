import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  String date = DateFormat('dd/MM/yyyy - kk:mm').format(
    DateTime.now(),
  );
  final CollectionReference cartCollection =
      Firestore.instance.collection('Cart');

  Future setUserData() async {
    return await cartCollection.document('1').setData({});
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
      'Time': 'Ordered at $date'
    };
    await cartCollection
        .document(uid)
        .setData({'$index': products}, merge: true);
  }
}
