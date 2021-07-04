class UserData {
  final String uid;
  final String name;
  final int mood;
  final bool workDone;

  UserData({this.uid, this.name, this.mood, this.workDone});
}

class UserNote {
  final String uid;
  final String title;
  final String description;
  final String gratitude;
  final String noteId;
  UserNote(
      {this.uid, this.gratitude, this.description, this.title, this.noteId});
}
