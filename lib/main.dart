import 'package:flutter/material.dart';
import 'package:well_being_app/home_page.dart';
import 'package:well_being_app/meditation.dart';
import 'package:well_being_app/profile_page.dart';
import 'package:well_being_app/quotes_page.dart';

import 'quotes_page.dart';
import 'quotes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'quotepage',
      routes: {
        'quotepage': (context) => QuoteScreen(),
        'HomeScreen': (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        'MeditationScreen': (context) => MeditationScreen(),
      },
    );
  }
}
