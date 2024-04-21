import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminDashboard.dart';

import '../Constants/AppColors.dart';
import '../Widgets/Buttons/SmallButton.dart';
import '../Widgets/FormFields.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}
void initState() {

}
class _AdminLoginState extends State<AdminLogin> {
  bool counsellor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 30,
          elevation: 0,
          backgroundColor: Color(0xFFC094F8),
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Row(
              children: const [
                Icon(
                  Icons.swap_calls,
                  size: 18,
                  color: AppColors.primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Switch to user',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ),
              ],
            ),
          )),
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
                        counsellor ? 'COUNSELLOR LOGIN' : 'STUFF LOGIN',
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
                     Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AdminDashboard(counsellor: counsellor?true:false)
                              ));
                             },
                            child: Container(
                              // height: 50,
                              // width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.fromLTRB(22, 10, 22, 10),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),

                                ),
                              ),
                            ),
                          ),
                    ),
                     )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    counsellor
                        ? "Are you a Stuff? Click here to "
                        : 'Are you a Counselllor? Click here to ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if(counsellor)
                          counsellor= false;
                        else
                          counsellor=  true;
                      });
                    },
                    child: Text(
                      counsellor ? 'Login as Stuff' : 'Login as Counsellor',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
