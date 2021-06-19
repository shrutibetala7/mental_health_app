import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/resources/loading.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserNote user = Provider.of<UserNote>(context);
    return StreamBuilder<List<UserNote>>(
      stream: DatabaseService(uid: user.uid).userNotesList,
      builder: (context, snapshot) {
        //Do not use snapshot!=null it throws an error for a split second
        if (snapshot.hasData) {
          List<UserNote> userNote = snapshot.data;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: userNote.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userNote[index].title),
                  subtitle: Text(
                    userNote[index].description,
                    maxLines: 1,
                  ),
                );
              });
        } else {
          return Loading();
        }
      },
    );
  }
}
