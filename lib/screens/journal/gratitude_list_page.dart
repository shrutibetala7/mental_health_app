import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/resources/loading.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class GratitudePage extends StatefulWidget {
  const GratitudePage({Key key}) : super(key: key);

  @override
  _GratitudePageState createState() => _GratitudePageState();
}

class _GratitudePageState extends State<GratitudePage> {
  @override
  Widget build(BuildContext context) {
    UserNote user = Provider.of<UserNote>(context);
    return StreamBuilder<List<UserNote>>(
      stream: DatabaseService(uid: user.uid).userGratitudeList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UserNote> userNote = snapshot.data;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: userNote.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userNote[index].gratitude),
                );
              });
        } else {
          return Loading();
        }
      },
    );
  }
}
