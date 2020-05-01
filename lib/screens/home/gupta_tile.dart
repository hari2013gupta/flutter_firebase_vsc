import 'package:flutter/material.dart';
import 'package:flutter_firebase_vsc/models/gupta.dart';

class GuptaTile extends StatelessWidget {
  
  final Gupta gupta;
  GuptaTile({this.gupta});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[gupta.strength],
           backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(gupta.name),
          subtitle: Text('Takes: ${gupta.sugars} sugar(s)'),
        ),
      ),
    );
  }
}