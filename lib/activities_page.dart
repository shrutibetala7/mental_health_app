import 'package:flutter/material.dart';
import 'package:well_being_app/resources/color_palette.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Wrap(
          spacing: 30,
          runSpacing: 20,
          // alignment: WrapAlignment.center,
          // runAlignment: WrapAlignment.center,
          // crossAxisAlignment: WrapCrossAlignment.center,

          children: [
            homeTile(Colors.amber),
            homeTile(bg_dark1),
            homeTile(bg_dark2),
            homeTile(journal_bg_dark2),
            homeTile(bg_light1),
            homeTile(bg_light2),
            homeTile(journal_bg_light2),
            homeTile(journal_bg_light1)
          ],
        ),
      ),
    );
  }

  Container homeTile(Color color) {
    return Container(
      //margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
      height: MediaQuery.of(context).size.width / 2.3,
      width: MediaQuery.of(context).size.width / 2.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }
}
