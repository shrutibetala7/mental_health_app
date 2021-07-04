import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class Gratitude extends StatefulWidget {
  Gratitude({Key key}) : super(key: key);

  @override
  _GratitudeState createState() => _GratitudeState();
}

class _GratitudeState extends State<Gratitude> {
  String gratitude = '';
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
                    hintText: 'Gratitude',
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                  onChanged: (val) {
                    setState(() {
                      gratitude = val;
                      //titleController.text = title;
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
                .createNewGratitudeCollection(gratitude);
            Navigator.pop(context);
            print("pressed");
          },
        ),
      ),
    );
  }
}
