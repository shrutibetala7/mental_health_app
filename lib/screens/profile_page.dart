import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  static String id;
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //
  final _formKey = GlobalKey<FormState>();
  bool _isLoggedIn = false;
  static GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      debugPrint("The error is: $err");
    }
  }

  _logout() async {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: _isLoggedIn
          ? Column(children: <Widget>[
              Text("Hey lovely ${_googleSignIn.currentUser.displayName}"),
              ClipOval(
                child: CircleAvatar(
                  child: Image.network(_googleSignIn.currentUser.photoUrl),
                ),
              ),
              TextButton(onPressed: () => _logout, child: Text("Logout")),
            ])
          : _loginColumn(),
    ));
  }

  Column _loginColumn() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _login(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
          child: Row(children: [
            Icon(Icons.login),
            SizedBox(width: 20),
            Text("LOGIN WITH GOOGLE"),
          ]),
        ),
      ],
    );
  }
}
