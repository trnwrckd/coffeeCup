import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeCup/models/brew.dart';
import 'package:coffeeCup/models/user.dart';

class DatabaseService {
  //uid to link the user to his slot in the database
  final String uid;
  DatabaseService({this.uid});

  //collection reference - if not created, will be created. nice.
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  // gives users a slot in the database when they sign up for the first time
  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      //map DBattr: var
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }

  //fucntion to turn snapshots to list of Brew obj
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          sugar: doc.data['sugar'] ?? '',
          strength: doc.data['strength'] ?? 0);
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugar: snapshot.data['sugar'],
        strength: snapshot.data['strength']);
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
