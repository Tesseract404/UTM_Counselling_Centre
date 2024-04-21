import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Models/CounsellorModel.dart';
import 'package:utm_counselling_centre/Widgets/DashboardHeaders.dart';
import 'package:utm_counselling_centre/Widgets/DocCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final firebaseAuthService _auth = firebaseAuthService();
  List<CounsellorModel> counsellors = [];
  bool isLoading = true;

  Future<void> _fetchCounsellors() async {
    try {
      List<CounsellorModel> fetchCounsellors = await _auth.fetchCounsellorDetails();
      setState(() {
        counsellors = fetchCounsellors;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching reports: $e');
      Fluttertoast.showToast(msg: "Error fetching reports");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCounsellors();
    print('Counsellors fetched: ${counsellors.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Text(
                    'COUNSELLING CENTER',
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 38,
                      fontFamily: GoogleFonts.oswald().fontFamily,
                    ),
                  ),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: DashboardHeaders(
                        image: 'assets/reports.png',
                        route: '/report',
                      ),
                    ),
                    Expanded(
                      child: DashboardHeaders(
                        image: 'assets/bookings.png',
                        route: '',
                      ),
                    ),
                  ],
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'Our Doctors and Counsellors',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                    )),
              ],
            ),
            isLoading
                ? const CircularProgressIndicator()
                :
            //Container(color: Colors.red,height: 12, width: double.infinity,)
            Expanded(
                    child: ListView.builder(
                      itemCount: counsellors.length,
                      itemBuilder: (context, index) {
                        final counsellor = counsellors[index];
                        return
                          //Container(color: Colors.red,height: 21, width: double.infinity,);
                            DocCard(
                          docName: counsellor.name,
                          degree: counsellor.degree,
                          clinic: counsellor.clinic_name,
                          email: counsellor.email,
                          image: counsellor.image,
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
