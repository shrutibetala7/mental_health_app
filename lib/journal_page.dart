import 'package:flutter/material.dart';
import 'package:well_being_app/resources/color_palette.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key key}) : super(key: key);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      width: 101,
      color: journal_bg_dark1,
    );
  }
}
