import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/screens/activities_page.dart';
import 'package:well_being_app/home_elements/stepper.dart';
import 'package:well_being_app/services/auth.dart';
import 'package:well_being_app/screens/journal/journal_page.dart';
import 'package:well_being_app/screens/profile_page.dart';
import 'package:well_being_app/resources/color_palette.dart';
import 'package:well_being_app/services/user.dart';

class HomeScreen extends StatefulWidget {
  static String id;
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ActivityScreen(),
    JournalScreen(),
    ProfileScreen()
  ];
  AuthService _auth = new AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        Provider<UserData>.value(
          value: UserData(uid: user.uid),
        ),
        Provider<UserNote>.value(
          value: UserNote(uid: user.uid),
        ),
      ],
      child: WillPopScope(
        onWillPop: () => SystemNavigator.pop(),
        child: SafeArea(
          child: Scaffold(
            drawerScrimColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'My Space',
                style: TextStyle(
                    fontSize: 24.0,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w900),
              ),
              centerTitle: true,
              backgroundColor: bg_black,
              toolbarHeight: 60,
              elevation: 0.0,
            ),
            //Drawer is side pop up
            //inside the drawer we have the stepper widget
            drawer: StepperWidget(),
            body: _children[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: onTabTapped,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 32.0,
                  ),
                  label: (""),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book,
                    size: 32.0,
                  ),
                  label: (""),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_rounded,
                    size: 32.0,
                  ),
                  label: (""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
