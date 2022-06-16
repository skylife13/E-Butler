import 'package:firebase_auth/firebase_auth.dart';

import '/Model/user.dart' as Us;
import '/Services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  Us.User _userFromFirebaseUser(User user) {
    return user != null ? Us.User(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<Us.User> get user {
    return _auth.authStateChanges().map((_userFromFirebaseUser));
    //.map((FirebaseUser user) => _UserFromFirebaseUser(user));
  }

  //sign with email & pass

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}
