import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:well_being_app/activities_page.dart';
import 'package:well_being_app/home_elements/stepper.dart';
import 'package:well_being_app/journal_page.dart';
import 'package:well_being_app/profile_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          //Drawer is side pop up
          //inside the drawer we have the stepper widget
          drawer: StepperWidget(),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: ("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: ("Journal"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: ("Profile"),
              ),
            ],
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
