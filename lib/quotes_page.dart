import 'package:flutter/material.dart';
import "package:well_being_app/resources/quote_list.dart";
import 'package:shimmer/shimmer.dart';
import 'dart:math';

class quote_screen extends StatelessWidget {
  const quote_screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random getIndex = new Random();
    int index = getIndex.nextInt(10);

    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Shimmer.fromColors(
            child: Center(
                child: Text(
              quotes_list[index],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            )),
            baseColor: Colors.grey,
            highlightColor: Colors.white));
  }
}
