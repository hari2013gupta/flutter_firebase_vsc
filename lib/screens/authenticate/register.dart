import 'package:flutter/material.dart';
import 'package:flutter_firebase_vsc/services/auth.dart';
import 'package:flutter_firebase_vsc/shared/constants.dart';
import 'package:flutter_firebase_vsc/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _State createState() => _State();
}

class _State extends State<Register> {

  final AuthService _auth = AuthService();
 
  final _formKey = GlobalKey<FormState>();

  String email = '', password = '', error = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text('Register to Hariom Gupta'),
        elevation: 0.0,
        actions: <Widget>[ 
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In')),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter your email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Enter a password minimum 6 charecter long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() {
                      loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailPasswordService(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Please provide a valid email';
                          loading = false;
                        });
                      } 
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                  error, 
                  style: TextStyle(fontSize: 14.0, color: Colors.pinkAccent)
                  ),
              ],
            ),
          )
          // RaisedButton(
          //   child: Text('sign in anonymous'),
          //   onPressed: () async {
          //     dynamic result = await _auth.signInAnon();
          //     if(result == null){
          //       print('sign in error');
          //     } else {
          //       print('sign in success');
          //       print(result.uid);
          //     }
          //   },
          // ),
          ),
    );
  }
}
