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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Information')
              .orderBy(FieldPath.documentId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i in document.data().values)
                      Text(
                        i['title'] + '\n' + i['description'],
                      ),
                  ],
                );
              }).toList(),
            );
          },
        ));
  }
}
