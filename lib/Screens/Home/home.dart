import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      create: null,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: const Text(
                "LogOut",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: const Text(
                'settings',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
