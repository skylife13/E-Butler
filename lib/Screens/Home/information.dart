import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ebutler/Screens/Notifications/components/default_appbar.dart';
import 'package:ebutler/Screens/Notifications/components/default_backbutton.dart';

import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key key}) : super(key: key);
  static const routeName = '/Information';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DefaultAppBar(
          title: 'Information',
          child: DefaultBackButton(),
        ),
        // appBar: AppBar(
        //   title: const Text('Information'),
        //   leading: const DefaultBackButton(),
        //   actions: <Widget>[
        //     TextButton.icon(
        //       icon: const Icon(Icons.person, color: Colors.white),
        //       onPressed: () async {
        //         await _auth.signOut();
        //       },
        //       label: const Text(
        //         'Logout',
        //         style: TextStyle(color: kPrimaryColor),
        //       ),
        //     ),
        //   ],
        // ),
        floatingActionButton: null,
        body: Center(
          child: ListView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('information')
                    .doc('Extension')
                    // .orderBy(FieldPath.documentId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(snapshot.data['title']),
                          Text(snapshot.data['description'])
                        ],
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('information')
                    .doc('Hotel Information')
                    // .orderBy(FieldPath.documentId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(snapshot.data['title']),
                          Text(snapshot.data['description'])
                        ],
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('information')
                    .doc('Outlet Location')
                    // .orderBy(FieldPath.documentId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(snapshot.data['title']),
                          Text(snapshot.data['description'])
                        ],
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ));
  }
}
