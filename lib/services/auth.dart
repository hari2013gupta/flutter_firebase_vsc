import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_vsc/models/user.dart';
import 'package:flutter_firebase_vsc/services/database.dart';

class AuthService {

final FirebaseAuth _auth = FirebaseAuth.instance;

//create a user object based on firebase
User _userFromFirebaseUser (FirebaseUser user){
  return user != null ? User(uid: user.uid) : null;
}

// auth change user stream
Stream<User> get user{
  return _auth.onAuthStateChanged
  // .map((FirebaseUser user)=>_userBasedOnFirebase(user));
  .map(_userFromFirebaseUser); // todo: understand above line, same as this line
}

  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  } 

  // sign in with email and password
  Future signInWithEmailPasswordService(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailPasswordService(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'hari 1', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // sign out
  Future signOutService() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

}