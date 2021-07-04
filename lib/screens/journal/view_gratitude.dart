import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class ViewGratitude extends StatefulWidget {
  Map data;
  String nid;
  ViewGratitude({Key key, this.data, this.nid}) : super(key: key);

  @override
  _ViewGratitudeState createState() => _ViewGratitudeState();
}

class _ViewGratitudeState extends State<ViewGratitude> {
  String gratitude;
  @override
  void initState() {
    setState(() {
      gratitude = widget.data['gratitude'];
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
                  initialValue: widget.data['gratitude'] ?? 'gratitude',
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 24),
                  ),
                  onChanged: (val) {
                    setState(() {
                      gratitude = val ?? widget.data['gratitude'];
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
                .updateGratitude(gratitude, widget.nid);
            Navigator.pop(context);
            print("$gratitude");
          },
        ),
      ),
    );
  }
}
