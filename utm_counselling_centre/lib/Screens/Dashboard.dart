import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Models/CounsellorModel.dart';
import 'package:utm_counselling_centre/Widgets/DashboardHeaders.dart';
import 'package:utm_counselling_centre/Widgets/DocCard.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/Buttons/ConfirmButton2.dart';

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
  Future<void> _logOut() async {
    try {
       await _auth.signOut();
    } catch (e) {
      print('Error fetching reports: $e');
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
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: (){

                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.zero,
                          title: const Center(
                            child: Text(
                              'Are you sure?',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color:AppColors.textColor,
                              ),
                            ),
                          ),
                          content:  Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child:   SingleChildScrollView(
                              child: ListBody(
                                  children: [Row(
                                    children: [
                                      Expanded(
                                        child: ConfirmButton2(
                                          title: 'Yes',
                                          color: Color(0xff9F9F9F),
                                          function: () {
                                            _logOut();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: ConfirmButton2(
                                          title: 'No',
                                          color: AppColors.secondaryColor,
                                          function: () {
                                            null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),]
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }, icon: const Icon(
                    Icons.logout_outlined,
                    color: AppColors.primaryColor,
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
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
                        route: '/schedule',
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
                          docName: counsellor.name!,
                          degree: counsellor.degree!,
                          clinic: counsellor.clinic_name!,
                          email: counsellor.email!,
                          image: counsellor.image!,
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
