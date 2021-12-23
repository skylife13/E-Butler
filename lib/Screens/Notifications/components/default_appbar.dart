import 'package:ebutler/Services/auth.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final action;
  const DefaultAppBar({
    Key key,
    this.title,
    this.child,
    this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return AppBar(
      title: Text(title, style: TextStyle(color: kPrimaryColor)),
      centerTitle: true,
      backgroundColor: kWhiteColor,
      elevation: kRadius,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: kPrimaryColor),
      leading: child,
      actions: <Widget>[
        TextButton.icon(
          icon: const Icon(Icons.person, color: kPrimaryColor),
          onPressed: () async {
            await _auth.signOut();
          },
          label: const Text(
            'Logout',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
