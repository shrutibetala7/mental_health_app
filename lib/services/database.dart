import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('Profile');
  final CollectionReference notesInfo =
      FirebaseFirestore.instance.collection('Notes');
  final CollectionReference gratitudeInfo =
      FirebaseFirestore.instance.collection('Gratitude');

  Future setUserData(String name, int mood, bool workDone) async {
    return await userInfo
        .doc(uid)
        .set({'name': name, 'mood': mood, 'workDone': workDone});
  }

  Future updateWorkDone(bool workDone) async {
    return await userInfo.doc(uid).update({'workDone': workDone});
  }

  Future createNewNoteCollection(String title, String description) async {
    return await notesInfo
        .doc(uid)
        .set({'title': title, 'description': description});
  }

  Future createNewNote(String title, String description) async {
    return await notesInfo
        .doc(uid)
        .collection('notes')
        .doc('${DateTime.now()}')
        .set({'title': title, 'description': description});
  }

  Future createNewGratitudeCollection(String gratitude) async {
    return await gratitudeInfo.doc(uid).set({'gratitude': gratitude});
  }

  Future createNewGratitude(String gratitude) async {
    return await gratitudeInfo
        .doc(uid)
        .collection('gratitude')
        .doc('${DateTime.now()}')
        .set({'gratitude': gratitude});
  }

  //convert the data from firestore to custom class
  //Query Snapshot contains several docs

  List<UserNote> _userNoteListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return UserNote(
          uid: uid,
          title: e.get('title') ?? 'title_fallback',
          description: e.get('description') ?? 'description_fallback');
    }).toList();
  }

  List<UserNote> _userGratitudeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return UserNote(
          uid: uid, gratitude: e.get('gratitude') ?? 'gratitude_fallback');
    }).toList();
  }

  //list of all docs
  Stream<List<UserNote>> get userNotesList {
    return notesInfo.snapshots().map(_userNoteListFromSnapshot);
  }

  Stream<List<UserNote>> get userGratitudeList {
    return gratitudeInfo.snapshots().map(_userGratitudeListFromSnapshot);
  }

  //Document snapshot contains one doc's info
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'), //older version snapshot.data['name'
      mood: snapshot.get('mood'),
      workDone: snapshot.get('workDone'),
    );
  }

  //single particular user data get stream
  Stream<UserData> get userData {
    return userInfo.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  UserNote _userNoteFromSnapshot(DocumentSnapshot snapshot) {
    return UserNote(
        uid: uid,
        title: snapshot.get('title'),
        description: snapshot.get('description'));
  }

  UserNote _userGratitudeFromSnapshot(DocumentSnapshot snapshot) {
    return UserNote(
      uid: uid,
      gratitude: snapshot.get('gratitude'),
    );
  }

  Stream<UserNote> get userNote {
    return notesInfo.doc(uid).snapshots().map(_userNoteFromSnapshot);
  }

  Stream<UserNote> get userGratitude {
    return gratitudeInfo.doc(uid).snapshots().map(_userGratitudeFromSnapshot);
  }
}
