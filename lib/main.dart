import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/authentication/register.dart';
import 'package:well_being_app/authentication/sign_in.dart';
import 'package:well_being_app/home_page.dart';
import 'package:well_being_app/services/auth.dart';
import 'package:well_being_app/resources/color_palette.dart';
import 'package:well_being_app/tiles/meditation.dart';
import 'package:well_being_app/screens/profile_page.dart';
import 'package:well_being_app/quotes_page.dart';
import 'package:well_being_app/tiles/podcast_screen.dart';

import 'quotes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          sliderTheme: SliderThemeData(
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.transparent,
            activeTrackColor: Colors.pink,
            inactiveTrackColor: Colors.amber,
            valueIndicatorTextStyle: TextStyle(fontSize: 40),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: bg_dark1,
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.fromLTRB(3, 1, 3, 1)),
          ),
        ),
        initialRoute: 'quotepage',
        routes: {
          'quotepage': (context) => QuoteScreen(),
          'wrapper': (context) => Wrapper(),
          'HomeScreen': (context) => HomeScreen(),
          'ProfileScreen': (context) => ProfileScreen(),
          'MeditationScreen': (context) => MeditationScreen(),
          'PodcastScreen': (context) => PodcastScreen(),
        },
      ),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      if (showSignIn)
        return SignIn(toggleView: toggleView);
      else
        return Register(toggleView: toggleView);
    } else
      return HomeScreen();
  }
}
