import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/resources/color_palette.dart';
import 'package:well_being_app/resources/loading.dart';
import 'package:well_being_app/screens/journal/gratitude.dart';
import 'package:well_being_app/screens/journal/gratitude_list_page.dart';
import 'package:well_being_app/screens/journal/note.dart';
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

    _newGratitude() async {}

    return StreamBuilder<UserNote>(
        stream: DatabaseService(uid: user.uid).userNote,
        builder: (context, snapshot) {
          if (snapshot != null) {
            UserNote userNoteInfo = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: FaIcon(
                      FontAwesomeIcons.bookmark,
                      size: 34.0,
                    ),
                  ),
                  backgroundColor: journal_bg_dark2,
                  title: Text(
                    'Journal',
                    style: TextStyle(fontSize: 34.0, letterSpacing: 2.0),
                  ),
                  elevation: 0.0,
                  centerTitle: true,
                ),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      backgroundColor: journal_bg_light1,
                      heroTag: 'NoteBUTTON',
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
                              backgroundColor: journal_bg_dark1,
                              padding: EdgeInsets.all(12.0),
                            ),
                            onPressed: () {
                              _toggle
                                  ? Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                      return Note();
                                    })).then((value) {
                                      setState(() {});
                                    })
                                  //then works only after
                                  : Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                      return Gratitude();
                                    })).then((value) {
                                      setState(() {});
                                    });
                            },
                            child: _toggle
                                ? Text('Todo Today')
                                : Text('Gratitude')),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                        ),
                        FloatingActionButton(
                          backgroundColor: journal_bg_light1,
                          heroTag: 'GratitudeBUTTON',
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
