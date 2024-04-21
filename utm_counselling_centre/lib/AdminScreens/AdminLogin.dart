import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/AdminScreens/AdminDashboard.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
 import '../Constants/AppColors.dart';
import '../Constants/Flush.dart';
import '../Widgets/Buttons/SmallButton.dart';
import '../Widgets/FormFields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

void initState() {}

class _AdminLoginState extends State<AdminLogin> {
  final firebaseAuthService _auth = firebaseAuthService();
  bool counsellor = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginCounsellor() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String conEmail1 = 'teebeechin@gmail.com';
    String conEmail2 = 'jinkiat123@gmail.com';
    String conEmail3 = 'phangcheng@gmail.com';
    String conEmail4 = 'joehang@gmail.com';
    String conEmail5 = 'waijenn@gmail.com';
    if (_emailController.text == conEmail1 ||
        _emailController.text == conEmail2 ||
        _emailController.text == conEmail3 ||
        _emailController.text == conEmail4 ||
        _emailController.text == conEmail5 ||
        _emailController.text == conEmail1) {
      User? user = await _auth.signInWithEmailAndPassword(email, password) ;
      if(user!=null){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AdminDashboard(counsellor: true)));
      }
    }else{
      Flush.showFlushBar( 'Invalid Credentials!');
    }
  }
void _loginStuff() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String stuffEmail1 = 'admin1@gmail.com';
    String stuffEmail2 = 'admin2@gmail.com';
    if (_emailController.text == stuffEmail1 ||
        _emailController.text == stuffEmail2 ) {
      User? user = await _auth.signInWithEmailAndPassword(email, password) ;
      if(user!=null){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AdminDashboard(counsellor: false)));
      }
    }else{
      Flush.showFlushBar( 'Invalid Credentials!');
    }
  }

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
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Row(
              children: [
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
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Container(
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
                                children: [
                                  FormFields(
                                    title: 'Email :',
                                    controller: _emailController,
                                    txtinp: TextInputType.emailAddress,
                                    password: false,
                                  ),
                                  FormFields(
                                    title: 'Password :',
                                    controller: _passwordController,
                                    txtinp: TextInputType.text,
                                    password: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  counsellor?_loginCounsellor():_loginStuff();
                                  _emailController.clear();
                                  _passwordController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                child: Container(
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
                            fontSize: 12,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (counsellor)
                                counsellor = false;
                              else
                                counsellor = true;
                            });
                          },
                          child: Text(
                            counsellor ? 'Login as Stuff' : 'Login as Counsellor',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
