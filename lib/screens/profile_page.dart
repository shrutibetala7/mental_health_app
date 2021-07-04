import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/resources/constants/shared.dart';
import 'package:well_being_app/resources/loading.dart';
import 'package:well_being_app/services/auth.dart';
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
  int _mood;
  bool _workDone;
  String _label = '😄';
  int workDoneRadioButtons;
  int _profileIndex = 0;

  List<String> profileIcon = [
    'assets/icons/profile_bird.svg',
    'assets/icons/profile_dog.svg',
    'assets/icons/profile_elephant.svg',
    'assets/icons/profile_giraffe.svg',
    'assets/icons/profile_monkey.svg',
    'assets/icons/profile_rabbit.svg',
    'assets/icons/profile_wolf.svg'
  ];

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    AuthService _auth = new AuthService();
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(alignment: AlignmentDirectional.center, children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset(
                            profileIcon[_profileIndex],
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 120,
                            child: IconButton(
                              onPressed: () {
                                _showBottomSheet();
                              },
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.black,
                              ),
                            ))
                      ]),
                      ListView(
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        children: [
                          ListTile(
                            title: Center(
                              child: Text(
                                "Hey ${userData.name}!",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w900),
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
                                  switch (val.toInt()) {
                                    case 100:
                                      {
                                        _label = '😄';
                                        _mood = 100;
                                        break;
                                      }
                                    case 200:
                                      {
                                        _label = '😍';
                                        _mood = 200;
                                        break;
                                      }
                                    case 300:
                                      {
                                        _label = '🥳';
                                        _mood = 300;
                                        break;
                                      }
                                    case 400:
                                      {
                                        _label = '😎';
                                        _mood = 400;
                                        break;
                                      }
                                    case 500:
                                      {
                                        _label = '😔';
                                        _mood = 500;
                                        break;
                                      }
                                    case 600:
                                      {
                                        _label = '😠';
                                        _mood = 600;
                                        break;
                                      }
                                  }
                                  DatabaseService(uid: userData.uid)
                                      .updateMood(_mood);
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
                            onTap: () {},
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
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Choose your animal spirit XD',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Wrap(
                      children: List.generate(profileIcon.length, (index) {
                    return InkWell(
                        onTap: () {
                          setState(() {
                            _profileIndex = index;
                          });
                        },
                        child: SvgPicture.asset(
                          profileIcon[index],
                          height: 50,
                          width: 50,
                        ));
                  })

                      // [
                      //   InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           _profileIndex = 0;
                      //         });
                      //       },
                      //       child: SvgPicture.asset(
                      //           'assets/icons/profile_panda.svg')),
                      //   InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         _profileIndex = 1;
                      //       });
                      //     },
                      //     child: SvgPicture.asset('assets/icons/profile_boy.svg'),
                      //   ),
                      //   InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         _profileIndex = 2;
                      //       });
                      //     },
                      //     child:
                      //         SvgPicture.asset('assets/icons/profile_panda.svg'),
                      //   ),
                      //   InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         _profileIndex = 3;
                      //       });
                      //     },
                      //     child:
                      //         SvgPicture.asset('assets/icons/profile_panda.svg'),
                      //   ),
                      // ],
                      )
                ],
              ),
            ),
          );
        });
  }

  _setWorkDone(int value, UserData userData) {
    setState(() {
      workDoneRadioButtons = value;
      if (value == 1 || value == 2)
        _workDone = true;
      else
        _workDone = false;

      DatabaseService(uid: userData.uid).updateWorkDone(_workDone);

      //debugPrint('Work done is ${userData.workDone.toString()}');
    });
  }
}
