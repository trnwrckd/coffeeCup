import 'package:coffeeCup/screens/authenticate/authenticate.dart';
import 'package:coffeeCup/screens/authenticate/sign_in.dart';
import 'package:coffeeCup/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeeCup/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //getting userinfo from stream in main.dart
    final user = Provider.of<User>(context);
    //print('${user.uid} from StreamProvider\nwrapper.dart');
    if (user == null)
      return Authenticate();
    else
      return Home();
    //return either home or authenticate widget
  }
}
