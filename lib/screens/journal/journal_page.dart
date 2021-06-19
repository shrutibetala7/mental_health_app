import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/resources/color_palette.dart';
import 'package:well_being_app/resources/loading.dart';
import 'package:well_being_app/screens/journal/gratitude_list_page.dart';
import 'package:well_being_app/screens/journal/notes_list.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key key}) : super(key: key);

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  bool _toggle = true;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserNote>(context);
    return StreamBuilder<UserNote>(
        stream: DatabaseService(uid: user.uid).userNote,
        builder: (context, snapshot) {
          if (snapshot != null) {
            UserNote userNote = snapshot.data;
            return Scaffold(
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _toggle = true;
                        });
                      },
                      child: Text('N'),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(8.0)),
                            onPressed: () {},
                            child: _toggle
                                ? Text('New Note')
                                : Text('New Gratitude')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _toggle = false;
                            });
                          },
                          child: Text('G'),
                        ),
                      ],
                    ),
                  ],
                ),
                body: _toggle ? NoteList() : GratitudePage());
          } else {
            return Loading();
          }
        });
  }
}
