import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:well_being_app/services/database.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in with email and pd
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print("Error with signing in ${e.toString()}");
      return null;
    }
  }

  //listen to changes
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //register with email and pd
  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      DatabaseService(uid: user.uid).setUserData('Buddy', 100, false);
      DatabaseService(uid: user.uid)
          .createNewNoteCollection('Title..', 'About it');
      DatabaseService(uid: user.uid).createNewGratitudeCollection('Gratitude');
      return user;
    } catch (e) {
      print("Error with registration ${e.toString()}");
      return null;
    }
  }

  //log out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error with signing out ${e.toString()}");
      return null;
    }
  }
}
