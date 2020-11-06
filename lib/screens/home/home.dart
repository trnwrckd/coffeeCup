import 'package:coffeeCup/models/brew.dart';
import 'package:coffeeCup/screens/home/SettingsForm.dart';
import 'package:coffeeCup/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffeeCup/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffeeCup/screens/home/brewlist.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('CoffeeCup'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          //used to add menu in appbar
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.logout),
              label: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 8,
                ),
              ),
              onPressed: () async {
                await _auth.signout(); // signout function from auth.dart
              },
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 8,
                ),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
