import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFF9999),
      child: const Center(
        child: SpinKitChasingDots(
          color: Color(0xFFFF6070),
          size: 50.0,
        ),
      ),
    );
  }
}
