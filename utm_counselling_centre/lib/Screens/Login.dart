import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:utm_counselling_centre/Constants/Flush.dart';
 import '../Firebase Authentication/firebase_auth_services.dart';
import '../Widgets/Buttons/SmallButton.dart';
import '../Widgets/Buttons/SmallButton2.dart';
import '../Widgets/FormFields.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firebaseAuthService _auth = firebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    _emailController.clear();
    _passwordController.clear();
    if (user != null) {
      Navigator.pushNamed(context, '/dash');
    }
  }
@override
  void initState() {
    // TODO: implement initState
  _emailController.clear();
  _passwordController.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 30,
          elevation: 0,
          backgroundColor: AppColors.tertiaryColor,
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, '/adminLogin');
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
                    'Switch to admin',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                  ),
                ),
              ],
            ),
          )),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        reverse: false,
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
                              'LOGIN',
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: SmallButton2(
                                  function: () {
                                    _login();
                                    FocusScope.of(context).unfocus();
                                  },
                                  title: 'Login',
                                )),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 30, 25, 0),
                          //   child: Align(
                          //       alignment: Alignment.centerRight,
                          //       child: SmallButton2(
                          //         function: () {
                          //           Flush.showFlushBar(context,'Workingggggggggg');
                          //         },
                          //         title: 'Login',
                          //       )),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Didn't registered yet? Click here to ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
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
