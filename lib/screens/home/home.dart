import 'package:flutter/material.dart';
import 'package:flutter_firebase_vsc/models/gupta.dart';
import 'package:flutter_firebase_vsc/screens/home/gupta_list.dart';
import 'package:flutter_firebase_vsc/screens/home/settings_form.dart';
import 'package:flutter_firebase_vsc/services/auth.dart';
import 'package:flutter_firebase_vsc/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingForm(),
        );
      });
    }
    return StreamProvider<List<Gupta>>.value(
      value: DatabaseService().gupta,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Home Screen - Hariom Gupta'),
          elevation: 0.0,
          actions: <Widget> [
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOutService();
                },
                icon: Icon(Icons.person),
                label: Text('logout')
                ),
              FlatButton.icon(
                onPressed: (){
                  _showSettingsPanel();
                }, 
                icon: Icon(Icons.settings), 
                label: Text('settings')
                )
          ],
        ),
        body: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/coffee_bg.png'),
             fit: BoxFit.cover,
             ),
         ),
          child: GuptaList()
          ),
      ),
    );
  }
}
