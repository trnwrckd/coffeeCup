// ALL SIGNIN AND REGISTER SERVICES TOGETHER

import 'package:coffeeCup/models/user.dart';
import 'package:coffeeCup/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //custom user object. model from user.dart
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //SIGN IN ANON
  // when auth changes occur, this sends back a value in the stream
  // either a user object, or null
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //Triggered by onPressed from SignInAnon button
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();

      //print("everything that's in AuthResult object\nauth.dart\n$result");
      FirebaseUser user = result.user; // only the user info is needed
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SIGN IN WITH EMAIL AND PASS

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: email);
      FirebaseUser user = result.user;
      //create a new document for the user with the uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('0', 'new member', 300);

      return _userFromFirebaseUser(user);
    } catch (e) {}
  }

  //REGISTER WITH EMAIL AND PASS
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: email);
      FirebaseUser user = result.user;
      //assigning user dummy values at sign up
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'Newly Registered User', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {}
  }

  //SIGN OUT
  // triggered by Logout button on homescreen appbar
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
