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
        floatingActionButton: null,
        body: Center(
          child: ListView(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('information')
                    .doc('Extension')
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
