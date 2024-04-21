import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/UserModel.dart';

class firebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Fluttertoast.showToast(msg: "Registered successfully!");
    } catch (e) {
      print('error 404');
      Fluttertoast.showToast(msg: "Registration Error, Invalid credentials");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Fluttertoast.showToast(msg: "Logged in successfully!");
      // print('user UID is >>>');
      // print(_auth.currentUser!.uid);
    } catch (e) {
      print('error 404');
      Fluttertoast.showToast(msg: "Login Error, Check your credentials");
    }
    return null;
  }

  Future<User?>  createUser(UserModel userModel)  async  {
    try{
      final userCollection = FirebaseFirestore.instance.collection("users");
      String id = userCollection.doc().id;
      final newUser = UserModel(
              id: id,
              username: userModel.username,
              email: userModel.email,
              phone: userModel.phone,
              password: userModel.password,
              UTMid: userModel.UTMid)
          .toJson();
      userCollection.doc(id).set(newUser);
    }catch(e){
      print(e);
    }
  }
}
