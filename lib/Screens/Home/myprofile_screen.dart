import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Model/user.dart';
import 'package:ebutler/Screens/Home/history_screen.dart';
import 'package:ebutler/Screens/Home/scheduled_screen.dart';
import 'package:ebutler/Screens/Notifications/components/default_backbutton.dart';
import 'package:ebutler/Services/auth.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);
  static const routeName = '/MyAccount';

  @override
  _State createState() => _State();
}

class _State extends State<MyProfile> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final AuthService _auth = AuthService();
    String uid = user.uid;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Text(
              "My Profile",
              style: TextStyle(color: kYellowColor),
            ),
          ),
          automaticallyImplyLeading: false),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Data User tidak ada');
              }

              return Card(
                color: kPrimaryColor,
                child: ListTile(
                  title: Text(snapshot.data['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: kYellowColor)),
                  subtitle: Text(snapshot.data['email'],
                      style: const TextStyle(color: kWhiteColor)),
                ),
              );
            },
          ),

          // const SizedBox(height: 10),
          //text "Accounts"
          // Container(
          //   alignment: Alignment.topLeft,
          //   padding: EdgeInsets.all(7),
          //   child: Text("Account", style: TextStyle(fontSize: 11)),
          // ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 22.0),
                  itemCount: accountLabel.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: Icon(
                          accountIcons[index],
                          color: kPrimaryColor,
                        ),
                        title: Text(
                          accountLabel[index],
                        ),
                        onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              switch (accountLabel[index]) {
                                case 'History':
                                  return const HistoryScreen();
                                  break;
                                case 'Scheduled Order':
                                  return const ScheduledScreen();
                                  break;

                                default:
                                  return null;
                              }
                            })));
                  })),

          TextButton.icon(
            icon: const Icon(Icons.exit_to_app, color: kPrimaryColor),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text(
              'Logout',
              style: TextStyle(color: kDarkColor),
            ),
          ),

          // ListView.builder(
          //   itemCount: profileList.length,
          //   itemBuilder: (context, index) {
          //     ListProfile profile = profileList[index];

          //     return Card(
          //       child: ListTile(
          //         title: Text(profile.title),
          //         trailing: Icon(Icons.arrow_forward),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
