import 'dart:ffi';
 import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Models/ReviewModel.dart';
import '../Constants/Flush.dart';
import '../Firebase Authentication/firebase_auth_services.dart';
import '../Widgets/Buttons/Backbutton.dart';
import '../Widgets/FeedCard.dart';
import '../Widgets/ScreenHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class AdminFeed extends StatefulWidget {
  const AdminFeed({Key? key}) : super(key: key);

  @override
  State<AdminFeed> createState() => _AdminFeedState();
}

class _AdminFeedState extends State<AdminFeed> {
  final firebaseAuthService _auth = firebaseAuthService();
  late List<ReviewModel> reviews = [];
  bool isLoading = true;
  String? counsellorName;
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await getName();
    if (counsellorName != null) {
      _fetchCounsellorReviews(counsellorName!);
    }
  }

  Future<void> _fetchCounsellorReviews(String counsellor) async {
    try {
      List<ReviewModel> fetchedReviews =
          await _auth.fetchCounsellorReviews(counsellor);
      setState(() {
        reviews = fetchedReviews;
        isLoading = false;
        print('Length: ${reviews.length}');
      });
    } catch (e) {
      print('Error fetching reports: $e');
      Flush.showFlushBar( 'Error fetching reports');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getName() async {
    counsellorName = await _auth.getCounsellorName();
    if (counsellorName != null) {
      print('Counsellor Name: $counsellorName');
    } else {
      print('It’s not a counsellor ID');
    }
  }
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Date not available';
    DateTime date = timestamp.toDate();
    String formattedTime = DateFormat.jm().format(date);
    String formattedDate = DateFormat('d MMMM yyyy').format(date);
    return '$formattedTime | $formattedDate';
  }
  double _averageRating(int aw1,int aw2,int kn1,int kn2,int sk1, int sk2){
    double rating = (aw1+aw2+kn1+kn2+sk1+sk2)/6;
    return double.parse(rating.toStringAsFixed(2));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Backbutton(),
          const ScreenHeader(
            home: false,
            title: "Patient's Feedback",
          ),
          isLoading
              ? const CircularProgressIndicator()
              : reviews.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            final rating = _averageRating(
                                int.parse(review.awareness1!),
                                int.parse(review.awareness2!),
                                int.parse(review.knowledge1!),
                                int.parse(review.knowledge2!),
                                int.parse(review.skill1!),
                                int.parse(review.skill2!)
                            );
                            return FeedCard(
                              title: review.userName,
                              date:formatTimestamp(review.timeDate), rating: rating,

                            );
                          }),
                    )
                  : const Center(
                      child: Text('No reports available!'),
                    ),
        ],
      ),
    );
  }
}
