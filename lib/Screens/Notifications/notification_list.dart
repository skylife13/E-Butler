import 'package:ebutler/Screens/Notifications/notification_page.dart';
import 'package:ebutler/Shared/constants.dart';
import 'components/default_backbutton.dart';
import 'package:flutter/material.dart';
import 'components/default_appbar.dart';
import 'components/notification_tiles.dart';

class NotificationList extends StatefulWidget {
  NotificationList({Key key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: 'Notifications',
        child: DefaultBackButton(),
      ),
      body: ListView.separated(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 12,
          itemBuilder: (context, index) {
            return NotificationTiles(
              title: 'E-Commerce',
              subtitle: 'Thanks for download E-Commerce app.',
              enable: true,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage())),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          }),
    );
  }
}
