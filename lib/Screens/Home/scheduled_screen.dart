import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '/Model/user.dart';

class ScheduledScreen extends StatefulWidget {
  const ScheduledScreen({Key key}) : super(key: key);
  static const routeName = '/scheduled';
  @override
  _ScheduledScreen createState() => _ScheduledScreen();
}

class _ScheduledScreen extends State<ScheduledScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String uid = user.uid;
    int roomNumber;

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('Scheduled Status')
                .where(FieldPath.documentId, isEqualTo: uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshotScheduledStatus) {
              return StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('Scheduled Cart')
                    .where(FieldPath.documentId, isEqualTo: uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshotScheduledCart) {
                  if (!snapshotScheduledStatus.hasData &&
                      !snapshotScheduledCart.hasData) {
                    return Center(child: Text('Data kosong'));
                  }
                  if (snapshotScheduledCart.data.documents.isEmpty) {
                    // Navigator.of(context).pushNamed('/');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBar(
                          title: Text('Current Scheduled Order'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            'There is no current scheduled order yet',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    );
                  }
                  var scheduledStatus = snapshotScheduledStatus.data.documents
                      .map((stat) => stat['Status'])
                      .toString();
                  return Column(
                    children: [
                      AppBar(
                        title: Text('Current Scheduled Order'),
                      ),
                      Expanded(
                        child: ListView(
                          children:
                              snapshotScheduledCart.data.documents.map((doc) {
                            roomNumber = null;
                            for (var i in doc.data.values) {
                              roomNumber = i['Room Number'];
                              break;
                            }
                            return Column(
                              children: [
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      roomNumber.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView(
                                    children: [
                                      for (var i in doc.data.values)
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Text(
                                                i['Title'].toString() +
                                                    ' ' +
                                                    i['Quantity'].toString() +
                                                    'x',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            scheduledStatus,
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Firestore.instance
                                                .collection('Scheduled Cart')
                                                .document(uid)
                                                .delete();
                                            Firestore.instance
                                                .collection('Scheduled Status')
                                                .document(uid)
                                                .delete();
                                          },
                                          child: Text('Cancel Order'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              );
            }));
  }
}
