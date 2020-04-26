import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_vsc/models/gupta.dart';
import 'package:flutter_firebase_vsc/models/user.dart';

class DatabaseService {

  String uid;
  DatabaseService({this.uid});

//collection reference
  final CollectionReference guptaCollection =
      Firestore.instance.collection('gupta');

  Future updateUserData(String sugar, String name, int strength) async {
    return guptaCollection.document(uid)
        .setData({'sugars': sugar, 'name': name, 'strenght': strength});
  }

//Gupta list from snapshot
List<Gupta> _guptaListFormSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
    return Gupta(
      name: doc.data['name'] ?? '',
      sugars: doc.data['sugars'] ?? '0',
      strength: doc.data['strenght'] ?? 0
      );
  }).toList();
}

//user data from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: snapshot.data['uid'],
    name: snapshot.data['name'],
    sugars: snapshot.data['sugars'],
    strength: snapshot.data['strenght']
  );
}

//get gupta stream
  Stream<List<Gupta>> get gupta {
    return guptaCollection.snapshots()
    .map(_guptaListFormSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return guptaCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
  // Stream<DocumentSnapshot> get userData {
  //   return guptaCollection.document(uid).snapshots();
  // }

}
