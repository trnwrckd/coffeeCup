import 'package:coffeeCup/services/auth.dart';
import 'package:coffeeCup/shared/constants.dart';
import 'package:coffeeCup/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //getting function toggleview from authenticate.dart
  //this is part of the widget, not the state
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //textfield value to be stored here
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to CoffeeCup'),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView(); //calling function that's on widget
                  },
                  icon: Icon(Icons.person),
                  label: Text(
                    'Register',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Please put email' : null,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Password has to be longer than 6 charcters'
                            : null,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Password',
                        ),
                        obscureText: true, // *******
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          //if input ok
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        },
                        color: Colors.pink[400],
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
