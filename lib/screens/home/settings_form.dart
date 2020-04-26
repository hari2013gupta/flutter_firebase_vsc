import 'package:flutter/material.dart';
import 'package:flutter_firebase_vsc/models/user.dart';
import 'package:flutter_firebase_vsc/services/database.dart';
import 'package:flutter_firebase_vsc/shared/constants.dart';
import 'package:flutter_firebase_vsc/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {

  final _formKey = GlobalKey<FormState>();
  List<String> sugarList = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName, _currentSugar;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
          if(snapshot.hasData) {

          UserData userData = snapshot.data;
  
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update Gupta settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                SizedBox(height: 20.0),

                //dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugar ?? userData.sugars,
                  items: sugarList.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars')
                    );
                }).toList(), 
                  onChanged: (val) => setState(() => _currentSugar = val), 
                ),

                // slider
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(), 
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                ),

                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    print(_currentName);
                    print(_currentSugar);
                    print(_currentStrength);

                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugar ?? userData.sugars, 
                        _currentName ?? userData.name, 
                        _currentStrength ?? userData.strength
                        );
                        Navigator.pop(context);
                    }
                } 
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
