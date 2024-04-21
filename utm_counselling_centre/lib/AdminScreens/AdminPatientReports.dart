import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/Backbutton.dart';
import '../Constants/Flush.dart';
import '../Models/ReportsModel.dart';
import '../Widgets/Buttons/CustomTinyButton.dart';
import '../Widgets/ScreenHeader.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class AdminPatientReports extends StatefulWidget {
  final bool counsellor;
  const AdminPatientReports({Key? key, required this.counsellor}) : super(key: key);

  @override
  State<AdminPatientReports> createState() => _AdminPatientReportsState();
}

class _AdminPatientReportsState extends State<AdminPatientReports> {
  final firebaseAuthService _auth = firebaseAuthService();
  late List<ReportModel> reports = [];
  bool isLoading = true;
  String? counsellorName;
  @override
  void initState() {
    super.initState();
    initialize();
  }
  void initialize() async {
    await getName();
    if (widget.counsellor && counsellorName != null) {
      _fetchCounsellorReports(counsellorName!);
    } else {
      _fetchAllReports();
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

  Future<void> _fetchCounsellorReports(String counsellor) async {
    try {
      //print('the name is $counsellorName');
      List<ReportModel> fetchedReports = await _auth.fetchCounsellorReports(counsellor);
      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching reports: $e');
      Flush.showFlushBar( 'Error fetching reports');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _fetchAllReports() async {
    try {
      List<ReportModel> fetchedReports = await _auth.fetchAllReports();
      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching reports: $e');
      Flush.showFlushBar( 'Error fetching reports');
      setState(() {
        isLoading = false;
      });
    }
  }
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'Date not available';
    DateTime date = timestamp.toDate();
    String formattedTime = DateFormat.jm().format(date);
    String formattedDate = DateFormat('d MMMM yyyy').format(date);
    return '$formattedTime | $formattedDate';
  }
  Future<void> _updateContent(String id, String content) async {
    try{
      await _auth.updateReport(id, content);
      print('done');
      _fetchAllReports();
    }catch(e){
      print(e);
    }
  }
  Future<void> _approveReport( String id) async {
    try{
      await _auth.approveReport(id);
      print('done');
      _fetchAllReports();
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Backbutton(),
          const ScreenHeader(
            home: false,
            title: 'Patient Report',
          ),
          isLoading?const CircularProgressIndicator()
          : reports.isNotEmpty?Expanded(
            child: ListView.builder(
              itemCount: reports.length ,
              itemBuilder: (context, index) {
                final report = reports[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: report.approved!?AppColors.accentColor:Color(0xfff0dfdf),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children:   [
                            Expanded(
                              child: ListTile(
                                leading: const Image(
                                  image: AssetImage('assets/default.png'),
                                ),
                                title: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      report.username!,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondaryColor
                                      ),
                                    ),
                                    Text(
                                      report.doctor!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.tertiaryColor
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle:  Text(
                                    formatTimestamp(report.timedate),
                                  style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textColor
                                  ),
                                ),

                              ),
                            ),
                             Column(
                               children: [
                                 !report.approved!?Padding(
                                   padding: const EdgeInsets.fromLTRB(1, 1 ,5, 1),
                                   child: CustomTinyButton(
                                    title: 'Approve',
                                     color: AppColors.secondaryColor,
                                     onTap: () {
                                      _approveReport(report.reportid!);
                                   } ,),
                                 ):Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Icon(CupertinoIcons.checkmark_alt_circle_fill,color: CupertinoColors.systemGreen,),
                                 ),
                               ],
                             ),
                          ],
                        ),
                          Container(
                            decoration:   BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              color: report.approved!?AppColors.tertiaryColor:Color(0xfff2bfbf)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(1, 0, 7, 0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    TextEditingController textController = TextEditingController(text: report.content);

                                    showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                              child: Text(
                                                'Report Details',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                          content: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(7, 3, 7, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.pGreyColor,
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: textController,
                                                    maxLines: null,
                                                    style: const TextStyle(
                                                      color: AppColors.secondaryTextColor,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                _updateContent(report.reportid!, textController.text);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Save',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: AppColors.secondaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child:const Padding(
                                    padding:  EdgeInsets.all(4),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )

                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ):const Center(
            child: Text(
              'No reports available!'
            ),
          ),
        ],
      ),
    );
  }
}
