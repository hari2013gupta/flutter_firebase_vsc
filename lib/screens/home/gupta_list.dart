import 'package:flutter/material.dart';
import 'package:flutter_firebase_vsc/models/gupta.dart';
import 'package:flutter_firebase_vsc/screens/home/gupta_tile.dart';
import 'package:provider/provider.dart';

class GuptaList extends StatefulWidget {
  @override
  _GuptaListState createState() => _GuptaListState();
}

class _GuptaListState extends State<GuptaList> {
  @override
  Widget build(BuildContext context) {

    final guptaList = Provider.of<List<Gupta>>(context) ?? [];

    // guptaList.forEach((gupta){
    //   print(gupta.name);
    //   print(gupta.strength);
    //   print(gupta.sugars);
    // });
    
    // print(gupta.documents);
    // for(var doc in gupta.documents){
    //   print(doc.data);
    // }

    return ListView.builder(
      itemCount: guptaList.length,
      itemBuilder: (context, index){
        return GuptaTile(gupta: guptaList[index]); 
      });
  }
}