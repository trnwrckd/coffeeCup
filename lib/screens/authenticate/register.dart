import 'package:coffeeCup/services/auth.dart';
import 'package:coffeeCup/shared/constants.dart';
import 'package:coffeeCup/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //getting function toggleview from authenticate.dart
  //this is part of the widget, not the state
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  //value from text field
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
              title: Text('Register'),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView(); //calling function that's on widget
                  },
                  icon: Icon(Icons.person),
                  label: Text(
                    'Log in',
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
                      validator: (val) => val.isEmpty ? "Enter Email" : null,
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
                          ? "Password has to be greater than 6"
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
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please Put valid email';
                            });
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              )),
            ),
          );
  }
}
