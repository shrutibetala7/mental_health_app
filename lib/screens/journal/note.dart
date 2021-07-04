import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class Note extends StatefulWidget {
  Note({Key key}) : super(key: key);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Provider<UserNote>.value(
      value: UserNote(uid: user.uid),
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                  onChanged: (val) {
                    setState(() {
                      title = val;
                      //titleController.text = title;
                    });
                  },
                ),
                TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Tell me about that..',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  onChanged: (val) {
                    setState(() {
                      description = val;
                      //descriptionController.text = description;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("save"),
          onPressed: () {
            DatabaseService(uid: user.uid)
                .createNewNoteCollection(title, description);
            Navigator.pop(context);
            print("pressed");
          },
        ),
      ),
    );
  }
}
