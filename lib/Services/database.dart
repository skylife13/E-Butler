import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference orderCollection =
      Firestore.instance.collection('Orders');

  Future updateUserData(
      String name, int cola, int pillow, int towel, int mineralwater) async {
    return await orderCollection.document(uid).setData({
      'name': name,
      'cola': cola,
      'pillow': pillow,
      'towel': towel,
      'mineralwater': mineralwater,
    });
  }

//userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      cola: snapshot.data['cola'],
      pillow: snapshot.data['pillow'],
      towel: snapshot.data['towel'],
      mineralwater: snapshot.data['mineralwater'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return orderCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
