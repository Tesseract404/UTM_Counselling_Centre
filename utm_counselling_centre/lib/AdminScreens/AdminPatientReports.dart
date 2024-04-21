import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import '../Widgets/Buttons/CustomTinyButton.dart';
import '../Widgets/ScreenHeader.dart';

class AdminPatientReports extends StatefulWidget {
  const AdminPatientReports({Key? key}) : super(key: key);

  @override
  State<AdminPatientReports> createState() => _AdminPatientReportsState();
}

class _AdminPatientReportsState extends State<AdminPatientReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(
            home: false,
            title: 'Patient Report',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 22 ,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children:   [
                          Expanded(
                            child: ListTile(
                              leading: const Image(
                                image: AssetImage('assets/default.png'),
                              ),
                              title: Text(
                                'Patient $index',
                              ),
                              subtitle: const Text(
                                'Age : 28'
                              ),

                            ),
                          ),
                          const CustomTinyButton(
                            title: 'Details', color: AppColors.textColor,
                          ),
                          const CustomTinyButton(
                            title: 'Reports', color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
