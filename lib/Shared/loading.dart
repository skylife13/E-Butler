import 'package:ebutler/Shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: const Center(
        child: SpinKitChasingDots(
          color: kYellowColor,
          size: 50.0,
        ),
      ),
    );
  }
}
