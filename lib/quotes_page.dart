import 'package:flutter/material.dart';
import "package:well_being_app/resources/quote_list.dart";
import 'package:shimmer/shimmer.dart';
import 'dart:math';
import 'package:well_being_app/home_page.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Random getIndex = new Random();
    int index = getIndex.nextInt(10);

    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'HomeScreen'),
        child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Shimmer.fromColors(
                child: Center(
                    child: Text(
                  quotesList[index],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                )),
                baseColor: Colors.grey,
                highlightColor: Colors.white)),
      ),
    );
  }
}
