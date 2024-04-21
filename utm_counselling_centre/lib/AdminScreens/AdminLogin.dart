import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/AppColors.dart';
import '../Widgets/Buttons/SmallButton.dart';
import '../Widgets/FormFields.dart';
class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 30,
          elevation: 0,
          backgroundColor: Color(0xFFC094F8),
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/login');
            },
            child: Row(
              children:const [
                Icon(
                  Icons.swap_calls,
                  size: 18,
                  color: AppColors.primaryColor,
                ),

                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text('Switch to user',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC094F8), Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      height: 130,
                      width: 130,
                      image: AssetImage('assets/logo.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'ADMIN LOGIN',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 38,
                          fontFamily: GoogleFonts.oswald().fontFamily,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                        child: Column(
                          children: const [
                            FormFields(title: 'Email :'),
                            FormFields(title: 'Password :'),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: SmallButton(
                            title: 'Login',
                            route: '/admindash',
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,)
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children:   [
            //       const Text(
            //         "Didn't registered yet? Click here to "  ,
            //         style: TextStyle(
            //           fontWeight: FontWeight.w400,
            //           fontSize: 14,
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: (){
            //           Navigator.pushNamed(context, '/register');
            //         },
            //         child: const Text(
            //           'Register',
            //           style: TextStyle(
            //             fontWeight: FontWeight.w700,
            //             fontSize: 14,
            //             color: AppColors.primaryColor,
            //
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
