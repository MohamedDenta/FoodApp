import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/scr/helpers/style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SpinKitFadingCircle(
            color: black,
            size: 30,
            //duration: Duration(milliseconds: 2000),
          ),
        ));
  }
}
