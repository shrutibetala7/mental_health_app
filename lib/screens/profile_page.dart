import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/resources/constants/shared.dart';
import 'package:well_being_app/resources/loading.dart';
import 'package:well_being_app/services/database.dart';
import 'package:well_being_app/services/user.dart';

class ProfileScreen extends StatefulWidget {
  static String id;
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //AuthService _auth = new AuthService();
  String _name;
  double _mood;
  bool _workDone;
  String _label = '😄';
  int workDoneRadioButtons;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CircleAvatar(
                          radius: 70,
                        ),
                        ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          children: [
                            ListTile(
                              title: Center(
                                child: Text(
                                  "Hey ${userData.name}!",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '⭐ How\'s your mood today? ',
                              style: TextStyle(fontSize: 20),
                            ),
                            Card(
                              margin: EdgeInsets.only(top: 38),
                              elevation: 10.0,
                              child: Slider(
                                value: _mood ?? 100,
                                divisions: 5,
                                min: 100,
                                max: 600,
                                onChanged: (val) {
                                  setState(() {
                                    _mood = val;
                                    switch (val.toInt()) {
                                      case 100:
                                        {
                                          _label = '😄';
                                          break;
                                        }
                                      case 200:
                                        {
                                          _label = '😍';
                                          break;
                                        }
                                      case 300:
                                        {
                                          _label = '😎';
                                          break;
                                        }
                                      case 400:
                                        {
                                          _label = '😔';
                                          break;
                                        }
                                      case 500:
                                        {
                                          _label = '😠';
                                          break;
                                        }
                                    }
                                    debugPrint('Current value is $val');
                                  });
                                },
                                label: _label,
                              ),
                              shape: outlinedInputBorder,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '⭐ Did we achieve our goals for today? ',
                              style: TextStyle(fontSize: 20),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [
                                  Text(
                                    'Done and Dusted',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Radio(
                                      value: 1,
                                      groupValue: workDoneRadioButtons,
                                      onChanged: (val) {
                                        _setWorkDone(val, userData);
                                      }),
                                ]),
                                Row(
                                  children: [
                                    Text(
                                      'Will be done!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Radio(
                                        value: 2,
                                        groupValue: workDoneRadioButtons,
                                        onChanged: (val) {
                                          _setWorkDone(val, userData);
                                        }),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Will do better tomorrow!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Radio(
                                        value: 3,
                                        groupValue: workDoneRadioButtons,
                                        onChanged: (val) {
                                          _setWorkDone(val, userData);
                                        })
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: Icon(Icons.card_giftcard),
                              title: Text('Rewards'),
                              shape: outlinedInputBorder,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Settings'),
                              shape: outlinedInputBorder,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: Icon(Icons.medical_services_outlined),
                              title: Text('Seek Professional Help'),
                              shape: outlinedInputBorder,
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  _setWorkDone(int value, UserData userData) {
    setState(() {
      workDoneRadioButtons = value;
      if (value == 1 || value == 2)
        _workDone = true;
      else
        _workDone = false;

      DatabaseService(uid: userData.uid)
          .updateUserData(userData.name, userData.mood, _workDone);

      //debugPrint('Work done is ${userData.workDone.toString()}');
    });
  }
}
