import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('Users');

  Future setUserData(String name, int mood, bool workDone) async {
    return await userInfo
        .doc(uid)
        .set({'name': name, 'mood': mood, 'workDone': workDone});
  }

  Future updateWorkDone(bool workDone) async {
    return await userInfo.doc(uid).update({'workDone': workDone});
  }

  Future updateMood(int mood) async {
    return await userInfo.doc(uid).update({'mood': mood});
  }

  //Document snapshot contains one doc's info
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'), //older version snapshot.data['name']
      mood: snapshot.get('mood'),
      workDone: snapshot.get('workDone'),
    );
  }

  //single particular user data get stream
  Stream<UserData> get userData {
    return userInfo.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  /*                              NOTE                                 */
  // createNewNoteCollection(String title, String description, String noteId) {
  //   return userInfo.doc(uid).collection('notes');
  // }

  Future createNewNoteCollection(String title, String description) async {
    return await userInfo.doc(uid).collection('notes').doc().set({
      'title': title,
      'description': description,
      //'nid': userInfo.doc(uid).collection('notes').doc().id
    });
  }

  Future updateNote(String title, String desc, String nid) async {
    return await userInfo
        .doc(uid)
        .collection('notes')
        .doc(nid)
        .update({'title': title, 'description': desc});
  }

  Future deleteNote(String nid) async {
    try {
      print(nid);
      return await userInfo.doc(uid).collection('notes').doc(nid).delete();
    } catch (e) {
      print("error :$e");
    }
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

  //list of all docs
  Stream<List<UserNote>> get userNotesList {
    return userInfo
        .doc(uid)
        .collection('notes')
        .snapshots()
        .map(_userNoteListFromSnapshot);
  }

  UserNote _userNoteFromSnapshot(DocumentSnapshot snapshot) {
    return UserNote(
        uid: uid,
        title: snapshot.get('title'),
        description: snapshot.get('description'),
        noteId: snapshot.get('nid'));
  }

  Stream<UserNote> get userNote {
    return userInfo.doc(uid).snapshots().map(_userNoteFromSnapshot);
  }

  /*                                GRATITUDE                              */

  // createNewGratitudeCollection(String gratitude, String noteId) {
  //   return userInfo.doc(uid).collection('gratitude');
  // }

  Future createNewGratitudeCollection(String gratitude) async {
    return await userInfo
        .doc(uid)
        .collection('gratitude')
        .doc()
        .set({'gratitude': gratitude, 'nid': '${DateTime.now()}'});
  }

  Future updateGratitude(String gratitude, String nid) async {
    return await userInfo
        .doc(uid)
        .collection('gratitude')
        .doc(nid)
        .update({'gratitude': gratitude});
  }

  Future deleteGratitude(String nid) async {
    try {
      print(nid);
      return await userInfo.doc(uid).collection('gratitude').doc(nid).delete();
    } catch (e) {
      print("error :$e");
    }
  }

  List<UserNote> _userGratitudeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return UserNote(
          uid: uid, gratitude: e.get('gratitude') ?? 'gratitude_fallback');
    }).toList();
  }

  Stream<List<UserNote>> get userGratitudeList {
    return userInfo
        .doc(uid)
        .collection('gratitude')
        .snapshots()
        .map(_userGratitudeListFromSnapshot);
  }

  UserNote _userGratitudeFromSnapshot(DocumentSnapshot snapshot) {
    return UserNote(
      uid: uid,
      gratitude: snapshot.get('gratitude'),
    );
  }

  Stream<UserNote> get userGratitude {
    return userInfo
        .doc(uid)
        .collection('gratitude')
        .doc()
        .snapshots()
        .map(_userGratitudeFromSnapshot);
  }
}
