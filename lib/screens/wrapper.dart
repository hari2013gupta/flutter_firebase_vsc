import 'package:flutter/material.dart';
import 'package:flutter_firebase_vsc/models/user.dart';
import 'package:flutter_firebase_vsc/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase_vsc/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print('user: $user');

    if(user == null){
    //return either home or AUTHENTICATE
      return Authenticate();
    } else {
      return Home();
    }
  }
}