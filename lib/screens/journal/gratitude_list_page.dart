import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/resources/loading.dart';
import 'package:well_being_app/screens/journal/view_gratitude.dart';
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

    //Do not use snapshot!=null it throws an error for a split second

    return FutureBuilder<QuerySnapshot>(
      future: DatabaseService(uid: user.uid)
          .userInfo
          .doc(user.uid)
          .collection('gratitude')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.size,
              itemBuilder: (context, index) {
                Map userNote = snapshot.data.docs[index].data();
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewGratitude(
                          data: userNote, nid: snapshot.data.docs[index].id);
                    })).then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    margin: EdgeInsets.all(6.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userNote['gratitude'] ?? "Smile. You got this!",
                            style: TextStyle(fontSize: 24.0),
                            maxLines: 3,
                          ),
                          IconButton(
                              onPressed: () {
                                DatabaseService(uid: user.uid)
                                    .deleteNote(snapshot.data.docs[index].id);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete_outline_rounded))
                        ],
                      ),
                    ),
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
