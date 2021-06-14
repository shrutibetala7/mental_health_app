import 'package:cloud_firestore/cloud_firestore.dart';
import '/services/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userInfo =
      FirebaseFirestore.instance.collection('Profile');

  Future updateUserData(String name, int mood, bool workDone) async {
    return await userInfo
        .doc(uid)
        .set({'name': name, 'mood': mood, 'workDone': workDone});
  }

  //convert the data from firestore to custom class
  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return UserData(
        name: e.get('name') ?? 'Buddy',
        mood: e.get('mood') ?? 0,
        workDone: e.get('workDone') ?? false,
      );
    }).toList();
  }

  //list of all docs
  Stream<List<UserData>> get userCredentialList {
    return userInfo.snapshots().map(_userDataListFromSnapshot);
  }

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
}
