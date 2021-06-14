import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:well_being_app/resources/color_palette.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: SpinKitChasingDots(
        color: bg_dark1,
        size: 50.0,
      )),
    );
  }
}
