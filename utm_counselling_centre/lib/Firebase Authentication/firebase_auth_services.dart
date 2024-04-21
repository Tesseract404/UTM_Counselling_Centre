import 'package:firebase_auth/firebase_auth.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utm_counselling_centre/Models/CounsellorModel.dart';
import 'package:utm_counselling_centre/Models/ReportsModel.dart';
import 'package:utm_counselling_centre/Models/ReviewModel.dart';
import 'package:utm_counselling_centre/Models/ScheduleModel.dart';
import '../Constants/Flush.dart';
import '../Models/UserModel.dart';

class firebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Flush.showFlushBar('Registered successfully!');
       return credential.user;
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = "The email is already in use.";
            break;
          case 'invalid-email':
            errorMessage = "The email address is not valid.";
            break;
          default:
            errorMessage = "Registration Error, Invalid credentials.";
            break;
        }
      } else {
        errorMessage = "An unknown error occurred.";
      }
      Flush.showFlushBar(errorMessage);
       return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Flush.showFlushBar('Logged in successfully!');
       return credential.user;
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "No user found with this email.";
            break;
          case 'wrong-password':
            errorMessage = "Incorrect password.";
            break;
          default:
            errorMessage = "Login Error, Check your credentials.";
            break;
        }
      } else {
        errorMessage = "An unknown error occurred.";
      }
      Flush.showFlushBar(errorMessage);
       return null;
    }
  }
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Flush.showFlushBar('Logged out successfully!');
     } catch (e) {
      Flush.showFlushBar('An error occurred while signing out!');
     }
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
    return null;
  }

  Future<void> createReport(ReportModel reportModel) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("users");
      final reportCollection = FirebaseFirestore.instance.collection("reports");
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
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
          approved: reportModel.approved,
          notified: reportModel.notified,
          timedate: Timestamp.now(),
        ).toJson();
        reportCollection.doc(reportid).set(newReport).then((value) {
          Flush.showFlushBar('Report Submitted');
         });
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> submitReview(ReviewModel reviewModel) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("users");
      final reviewCollection = FirebaseFirestore.instance.collection("reviews");
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in!');
        return;
      }
      String id = currentUser.uid;
      print(id);
      DocumentSnapshot userDoc = await userCollection.doc(id).get();
      if (userDoc.exists) {
        String username = userDoc.get("username");
        String UTMid = userDoc.get("UTMid");

        String reviewId = reviewCollection.doc().id;
        //print('im here working');
        final newReview = ReviewModel(
          reviewId: reviewId,
          userId: id,
          userName: username,
          UTMid: UTMid,
          counsellor: reviewModel.counsellor,
          timeDate: Timestamp.now(),
          notify: reviewModel.notify,
          awareness1: reviewModel.awareness1,
          awareness2: reviewModel.awareness1,
          knowledge1: reviewModel.knowledge1,
          knowledge2: reviewModel.knowledge2,
          skill1: reviewModel.skill1,
          skill2: reviewModel.skill2,
        ).toJson();
        reviewCollection.doc(reviewId).set(newReview).then((value) {
           Flush.showFlushBar('Review Submitted');
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
        Flush.showFlushBar('No user logged in!');
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
  Future<List<ReportModel>> fetchCounsellorReports(String name) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in!');
         return [];
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("reports")
          .where("doctor", isEqualTo: name )
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
  Future<List<ReviewModel>> fetchCounsellorReviews(String name) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
         return [];
      }
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("reviews")
          .where("counsellor", isEqualTo: name )
          .get();

      List<ReviewModel> reviews = querySnapshot.docs.map((doc) {
        return ReviewModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return reviews;
    } catch (e) {
      print('Fetch reviews Error: $e');
      return [];
    }
  }

  Future<List<ReportModel>> fetchAllReports() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return [];
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("reports")
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

  Future<List<ScheduleModel>> fetchUserSchedules() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return [];
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("schedules")
          .where("userid", isEqualTo: currentUser.uid)
          .get();

      List<ScheduleModel> schedules = querySnapshot.docs.map((doc) {
        return ScheduleModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return schedules;
    } catch (e) {
      print('Fetch Schedules Error: $e');
      return [];
    }
  }
  Future<List<ScheduleModel>> fetchAllSchedules() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return [];
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("schedules")
          .get();

      List<ScheduleModel> schedules = querySnapshot.docs.map((doc) {
        return ScheduleModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return schedules;
    } catch (e) {
      print('Fetch Schedules Error: $e');
      return [];
    }
  }
  Future<List<ScheduleModel>> fetchCounsellorSchedules(String counsellor) async {
    try {

      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return [];
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("schedules")
          .where('counsellor',isEqualTo: counsellor)
          .get();

      List<ScheduleModel> schedules = querySnapshot.docs.map((doc) {
        return ScheduleModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return schedules;
    } catch (e) {
      print('Fetch Schedules Error: $e');
      return [];
    }
  }
  
  Future<List<CounsellorModel>> fetchCounsellorDetails() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance
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
  Future<String?> getCounsellorName() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print('User is not logged in');
      return null;
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("counsellor")
          .where("id", isEqualTo: currentUser.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        String? name = doc['name'] as String?;
        return name;
      } else {
        print('No counsellor found with the given id');
        return null;
      }
    } catch (e) {
      print('Error retrieving counsellor name: $e');
      return null;
    }
  }

  Future<void> createSchedule(ScheduleModel scheduleModel) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection("users");
      final scheduleCollection =
          FirebaseFirestore.instance.collection("schedules");
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return;
      }
      String id = currentUser.uid;
      print(id);
      DocumentSnapshot userDoc = await userCollection.doc(id).get();
      if (userDoc.exists) {
        String username = userDoc.get("username");
        String UTMid = userDoc.get("UTMid");
        String scheduleid = scheduleCollection.doc().id;
        print('im here working');
        final newSchedule = ScheduleModel(
          userid: id,
          scheduleid: scheduleid,
          username: username,
          UTMid: UTMid,
          counsellor: scheduleModel.counsellor,
          timedate: scheduleModel.timedate,
          done: scheduleModel.done,
          approved: scheduleModel.approved,
          notified: scheduleModel.notified,
        ).toJson();
        scheduleCollection.doc(scheduleid).set(newSchedule).then((value) {
            Flush.showFlushBar('Meeting Scheduled');
        });
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> updateScheduleDone(String scheduleid) async {
    try {
       User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return;
      }
      final scheduleCollection = FirebaseFirestore.instance.collection("schedules");
      DocumentReference scheduleDoc = scheduleCollection.doc(scheduleid);
      await scheduleDoc.update({'done': true});
      Flush.showFlushBar('Schedule updated successfully');

    } catch (e) {
      print("Error updating schedule: $e");
      Flush.showFlushBar('Error updating schedule');
     }
  }
  Future<void> updateReport( String reportId ,String content) async {
    try {
      final reportCollection = FirebaseFirestore.instance.collection("reports");
      DocumentReference reportDoc = reportCollection.doc(reportId);
      await reportDoc.update({'content': content});
      Flush.showFlushBar('Report updated successfully');

    } catch (e) {
      print("Error updating report: $e");
      Flush.showFlushBar('Error');

    }
  }
  Future<void> notifyAllReports() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Flush.showFlushBar('No user logged in');
        return;
      }
      final userId = user.uid;
      final reportCollection = FirebaseFirestore.instance.collection("reports");
      QuerySnapshot querySnapshot = await reportCollection.where('id', isEqualTo: userId).get();
      if (querySnapshot.docs.isEmpty) {
        return;
      }
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (DocumentSnapshot doc in querySnapshot.docs) {
        batch.update(doc.reference, {'notified': true});
      }
      await batch.commit();
    } catch (e) {
      print("Error updating reports: $e");
    }
  }
  Future<void> notifyAllSchedule() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Flush.showFlushBar('No user logged in');
        return;
      }
      final userId = user.uid;
      final scheduleCollection = FirebaseFirestore.instance.collection("schedules");
      QuerySnapshot querySnapshot = await scheduleCollection
          .where('userid', isEqualTo: userId)
          .where('approved',isEqualTo: true)
          .get();
      if (querySnapshot.docs.isEmpty) {
        return;
      }
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (DocumentSnapshot doc in querySnapshot.docs) {
        batch.update(doc.reference, {'notified': true});
      }
      await batch.commit();
    } catch (e) {
      print("Error updating schedules: $e");
    }
  }

  Future<bool> hasUnnotifiedApprovedSchedules() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return false;
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("schedules")
          .where("userid", isEqualTo: currentUser.uid)
          .where("notified", isEqualTo: false)
          .where("approved", isEqualTo: true)
          .get();
      return querySnapshot.docs.isNotEmpty;

    } catch (e) {
      print('Check Schedules Error: $e');
      return false;
    }
  }
  Future<bool> hasUnnotifiedApprovedReports() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return false;
      }
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("reports")
          .where("id", isEqualTo: currentUser.uid)
          .where("notified", isEqualTo: false)
          .where("approved", isEqualTo: true)
          .get();
      print(querySnapshot.docs.isNotEmpty);
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Check Schedules Error: $e');
      return false;
    }
  }
  Future<bool> hasUpcomingSchedules() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return false;
      }
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("schedules")
          .where("userid", isEqualTo: currentUser.uid)
          .where("done", isEqualTo: false)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Check Schedules Error: $e');
      return false;
    }
  }
  Future<List<ScheduleModel>> UpcomingSchedules() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        Flush.showFlushBar('No user logged in');
        return [];
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("schedules")
          .where("userid", isEqualTo: currentUser.uid)
          .where("done", isEqualTo: false)
          .get();
      List<ScheduleModel> schedules = querySnapshot.docs.map((doc) {
        return ScheduleModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return schedules;
    } catch (e) {
      print('Check Schedules Error: $e');
      return [];
    }
  }

  Future<void> approveReport( String reportId) async {
    try {
      final reportCollection = FirebaseFirestore.instance.collection("reports");
      DocumentReference reportDoc = reportCollection.doc(reportId);
      await reportDoc.update({'approved': true});
      Flush.showFlushBar('Report updated successfully');

    } catch (e) {
      print("Error updating report: $e");
      Flush.showFlushBar('Error updating report');
     }
  }
  Future<void> approveSchedule( String scheduleId) async {
    try {
      final scheduleCollection = FirebaseFirestore.instance.collection("schedules");
      DocumentReference scheduleDoc = scheduleCollection.doc(scheduleId);
      await scheduleDoc.update({'approved': true});
      Flush.showFlushBar('schedule updated successfully');


    } catch (e) {
      print("Error updating schedule: $e");
      Flush.showFlushBar('Error updating schedule');
     }
  }
}
