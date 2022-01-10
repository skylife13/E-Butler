import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '/Model/user.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key key}) : super(key: key);
  static const routeName = '/status';
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String uid = user.uid;
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_x62chJ.json'),
          ),
          StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('Status')
                .document(uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshotStatus) {
              if (!snapshotStatus.hasData) {
                // Navigator.of(context).pushNamed('/');
                return Container(
                  child: Text('kosong'),
                );
              }

              return Column(
                children: [
                  if (snapshotStatus.data != null)
                    Text(snapshotStatus.data['Status']),
                  if (snapshotStatus.data['Status'] == 'Order is finished')
                    ElevatedButton(
                      onPressed: () {
                        Firestore.instance
                            .collection('Status')
                            .document(uid)
                            .delete();
                        Navigator.of(context).pushNamed('/');
                      },
                      child: Text('Finish Order'),
                    ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
