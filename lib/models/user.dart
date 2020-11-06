// CREATING MODEL FOR USER. ONLY  uid IS NEEDED FOR THIS APP

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  String uid;
  String name;
  String sugar;
  int strength;

  UserData({this.uid, this.name, this.sugar, this.strength});
}
