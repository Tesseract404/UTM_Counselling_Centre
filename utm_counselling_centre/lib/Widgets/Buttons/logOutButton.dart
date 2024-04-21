import 'package:flutter/material.dart';

import '../../Constants/AppColors.dart';
import '../../Firebase Authentication/firebase_auth_services.dart';
import 'ConfirmButton2.dart';
class logOutButton extends StatelessWidget {
  const logOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService _auth = firebaseAuthService();
    Future<void> _logOut() async {
      try {
        await _auth.signOut();
      } catch (e) {
        print('Error fetching reports: $e');
      }
    }
    return Align(
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
    );
  }
}
