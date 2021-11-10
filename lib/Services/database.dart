import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference cartCollection =
      Firestore.instance.collection('Cart');

  Future updateUserData() async {
    return await cartCollection.document(uid).setData({});
  }

  Future updateUserCart(
    String id,
    double amount,
    String title,
    double total,
    double price,
    int quantity,
  ) async {
    Map<String, Object> products = {
      'Title': title,
      'Price': price,
      'Quantity': quantity,
      'Total': total,
      'Time': DateTime.now()
    };
    await cartCollection
        .document(uid)
        .updateData({'Products $id': products, 'Total Price': amount});
  }
}
