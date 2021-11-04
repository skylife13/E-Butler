import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference cartCollection =
      Firestore.instance.collection('Cart');

  Future updateUserData(double amount) async {
    return await cartCollection.document(uid).setData({
      'id': DateTime.now().toString(),
      'amount': amount,
      'dateTime': DateTime.now(),
    });
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
      'price': price,
      'quantity': quantity,
      'total': total,
      'title': title,
    };
    await cartCollection
        .document(uid)
        .updateData({'Products $id': products, 'amount': amount});
  }
}
