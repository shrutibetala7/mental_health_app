import 'package:flutter/material.dart';
import 'package:well_being_app/services/auth.dart';
import 'package:well_being_app/resources/color_palette.dart';
import 'package:well_being_app/resources/constants/shared.dart';
import 'package:well_being_app/resources/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({Key key, this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String pd = '';
  String error = '';
  final AuthService _auth = new AuthService();
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Welcome back'),
              centerTitle: true,
              leading: Icon(Icons.assignment_ind),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              actions: [
                ElevatedButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign Up'),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
                    decoration:
                        inputFieldDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        inputFieldDecoration.copyWith(hintText: 'Password'),
                    validator: (val) =>
                        val.length < 6 ? 'Enter password >6' : null,
                    onChanged: (val) {
                      setState(() {
                        pd = val;
                      });
                    },
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.signIn(email, pd);
                        if (result != null) {
                          print('Submitted successfully $result');
                        } else
                          print('Error submitting');
                      }
                    },
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: bg_black,
                    ),
                  ),
                ]),
              ),
            ),
          )
        : Loading();
  }
}
