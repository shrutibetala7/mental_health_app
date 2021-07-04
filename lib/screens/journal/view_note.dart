import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class ViewNote extends StatefulWidget {
  Map data;
  String nid;
  ViewNote({Key key, this.data, this.nid}) : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title = '';
  String description = '';
  @override
  void initState() {
    setState(() {
      title = widget.data['title'];
      description = widget.data['description'];
    });

    super.initState();
  }

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
                  initialValue: widget.data['title'] ?? 'title',
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                  onChanged: (val) {
                    setState(() {
                      title = val ?? widget.data['title'];
                    });
                  },
                ),
                TextFormField(
                  initialValue: widget.data['description'] ?? 'description',
                  decoration: InputDecoration(
                    hintText: 'Tell me about that..',
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                  onChanged: (val) {
                    setState(() {
                      description = val ?? widget.data['description'];
                      //descriptionController.text = description;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("update"),
          onPressed: () {
            DatabaseService(uid: user.uid)
                .updateNote(title, description, widget.nid);
            Navigator.pop(context);
            print("$title and $description");
          },
        ),
      ),
    );
  }
}
