import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utm_counselling_centre/Models/CounsellorModel.dart';
import 'package:utm_counselling_centre/Models/ReportsModel.dart';
import '../Models/UserModel.dart';

class firebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email,
      String password) async {
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

  Future<User?> signInWithEmailAndPassword(String email,
      String password) async {
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

  Future<User?> createUser(UserModel userModel) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("users");
      //print();
      String id = _auth.currentUser!.uid;
      final newUser = UserModel(
          id: id,
          username: userModel.username,
          email: userModel.email,
          phone: userModel.phone,
          password: userModel.password,
          UTMid: userModel.UTMid)
          .toJson();
      userCollection.doc(id).set(newUser);
    } catch (e) {
      print(e);
    }
  }

  Future<void> createReport(ReportModel reportModel) async {
    try {
       final userCollection = FirebaseFirestore.instance.collection("users");
      final reportCollection = FirebaseFirestore.instance.collection("reports");
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {

        Fluttertoast.showToast(msg: "No user logged in");
        return;
      }
      //String id = userCollection.doc().id;
      String id = currentUser.uid;
       print(id);
      DocumentSnapshot userDoc = await userCollection.doc(id).get();
      if (userDoc.exists) {
        String username = userDoc.get("username");
        String UTMid = userDoc.get("UTMid");

        String reportid = reportCollection.doc().id;
        print('im here working');
        final newReport = ReportModel(
          id: id,
          reportid: reportid,
          username: username,
          UTMid: UTMid,
          content: reportModel.content,
          doctor: reportModel.doctor,
          timedate: Timestamp.now(),
        ).toJson();
        reportCollection.doc(reportid).set(newReport).then((value) {

          Fluttertoast.showToast(msg: "Report Submitted");
        });
      }
    } catch (e) {
      print(e);
    }
  }
  Future<List<ReportModel>> fetchUserReports() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Fluttertoast.showToast(msg: "No user logged in");
        return [];
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("reports")
          .where("id", isEqualTo: currentUser.uid)
          .get();

      List<ReportModel> reports = querySnapshot.docs.map((doc) {
        return ReportModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return reports;
    } catch (e) {
      print('Fetch Reports Error: $e');
      return [];
    }
  }
  Future<List<CounsellorModel>> fetchCounsellorDetails() async {
    try {
      // User? currentUser = _auth.currentUser;
      // if (currentUser == null) {
      //   Fluttertoast.showToast(msg: "No user logged in");
      //   return [];
      // }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("counsellor")
          .get();
      if (querySnapshot.docs.isEmpty) {
        print("No documents found in 'counsellor' collection.");
      } else {
        print("Documents found: ${querySnapshot.docs.length}");
      }
      print('im here!!');
      List<CounsellorModel> counsellors = querySnapshot.docs.map((doc) {
        return CounsellorModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return counsellors;
    } catch (e) {
      print('Fetch Counsellors Error: $e');
      return [];
    }
  }
}