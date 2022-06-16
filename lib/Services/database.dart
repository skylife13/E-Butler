import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  String date = DateFormat('dd/MM/yyyy - kk:mm').format(
    DateTime.now(),
  );
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('Cart');

  Future setUserData() async {
    return await cartCollection.doc('1').set({});
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
        .doc(uid)
        .set({'$index': products}, SetOptions(merge: true));
  }
}
