import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

//Masih ga optimal soalnya kalo tiap detik beda document, karena loop butuh
//waktu milisecond, kalau user pesen misal tepat 1ms sblm pindah detik
//nanti document kebikin jadi 2x

class History {
  final String uid;

  History({this.uid});
  DateTime time = DateTime.now();
  String newTime;

  Future setHistory(int index, String itemTitle, int quantity, int price,
      int roomNumber, String id, int amount, int total) async {
    newTime = DateFormat('dd:MM:yy kk:mm:ss').format(time);
    Map<String, Object> history = {
      'Room Number': roomNumber,
      'Item Id': id,
      'Item': itemTitle,
      'Price': price,
      'Quantity': quantity,
      'Total': total,
      'Total Price': amount,
      'Time': DateTime.now()
    };

    return await Firestore.instance
        .collection(uid)
        .document(newTime)
        .setData({'$index': history}, merge: true);
  }
}
