import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Widgets/DashboardHeaders.dart';
import 'package:utm_counselling_centre/Widgets/DocCard.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Center(
        child: Column(
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
            Row(
              children: const [
                Expanded(
                  child: DashboardHeaders(image: 'assets/reports.png',route: '',),
                ),Expanded(
                   child: DashboardHeaders(image: 'assets/bookings.png',route: '',),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text('Our Doctors and Counsellors',
                    style: TextStyle(
                       fontWeight: FontWeight.w600,
                      fontSize: 25,
                     ),
                  ),
                )),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children:   const [
                      DocCard(docName: 'Counsellor 1',image: 'assets/doc1.png',),
                      DocCard(docName: 'Counsellor 2',image: 'assets/doc2.png',),
                      DocCard(docName: 'Counsellor 3',image: 'assets/doc3.png',),
                      DocCard(docName: 'Counsellor 4',image: 'assets/doc4.png',),
                      DocCard(docName: 'Counsellor 5',image: 'assets/doc5.png',),
                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
