import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Screens/Login.dart';

import '../../Constants/AppColors.dart';
import '../../Firebase Authentication/firebase_auth_services.dart';
import 'ConfirmButton2.dart';

class logOutButton extends StatelessWidget {
  const logOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService _auth = firebaseAuthService();

    Future<void> _logOut(BuildContext context) async {
      try {
        await _auth.signOut();
        // Navigate to the login screen and clear the stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => false,
        );
      } catch (e) {
        print('Error logging out: $e');
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 7, 2),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
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
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ConfirmButton2(
                                  title: 'Yes',
                                  color: const Color(0xff9F9F9F),
                                  function: () {
                                    _logOut(context);
                                  },
                                ),
                              ),
                              Expanded(
                                child: ConfirmButton2(
                                  title: 'No',
                                  color: AppColors.secondaryColor,
                                  function: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(
            Icons.logout_outlined,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
