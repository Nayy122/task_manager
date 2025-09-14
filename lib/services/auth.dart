import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:task_manager/screens/authenticate/sign_in.dart';
import 'package:task_manager/services/database.dart';
class User{
  final String uid;
  User({required this.uid});
}
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _userFromFirebaseUser(fbAuth.User? user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      fbAuth.UserCredential result = await _auth.signInAnonymously();
      fbAuth.User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SignInWithEmailPassword(String email,String password) async {
    try{
      fbAuth.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      fbAuth.User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
     Future regWithEmailPassword(String email,String password) async {
    try{
      fbAuth.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      fbAuth.User? user = result.user;
      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new task', 1);
      return _userFromFirebaseUser(user);
    }catch(e){
        print(e.toString());
        return null;
    }
     }


      Future signOut() async {
        try {
          return await _auth.signOut();
        } catch (e) {
          print(e.toString());
          return null;
        }
      }
    }
