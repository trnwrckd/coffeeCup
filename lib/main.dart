import 'package:coffeeCup/screens/wrapper.dart';
import 'package:coffeeCup/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeeCup/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //listens to the stream in auth.dart and decides what wrapper should show onscreen
    return StreamProvider<User>.value(
      value: AuthService().user, // from auth.dart
      child: MaterialApp(
        // Wrapper checks if user is logged in and shows homescreen or authentication
        home: Wrapper(),
      ),
    );
  }
}
