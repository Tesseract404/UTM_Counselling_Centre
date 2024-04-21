import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Firebase%20Authentication/firebase_auth_services.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/SmallButton.dart';
import '../Models/UserModel.dart';
import '../Widgets/Buttons/SmallButton2.dart';
import '../Widgets/FormFields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firebaseAuthService _auth = firebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _utmidController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _utmidController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
     String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
     User? user = await _auth.signUpWithEmailAndPassword(email, password);
     if (user != null) {
       _createUser();
      Navigator.pushNamed(context, '/dash');
    }
  }


  void _createUser() async {
    String username = _usernameController.text;
    String UTMid = _utmidController.text;
    String phone = _phoneController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user = await _auth.createUser(UserModel(
      username: username,
      email: email,
      phone: phone,
      password: password,
      UTMid: UTMid,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              height: 100,
                              width: 100,
                              image: AssetImage('assets/logo.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'REGISTER',
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
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.sGreyColor),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 15),
                                  child: Column(
                                    children: [
                                      FormFields(
                                        title: 'Name :',
                                        controller: _usernameController,
                                        txtinp: TextInputType.text,
                                        password: false,
                                      ),
                                      FormFields(
                                        title: 'UTMID :',
                                        controller: _utmidController,
                                        txtinp: TextInputType.number,
                                        password: false,
                                      ),
                                      FormFields(
                                        title: 'Email :',
                                        controller: _emailController,
                                        txtinp: TextInputType.emailAddress,
                                        password: false,
                                      ),
                                      FormFields(
                                        title: 'Phone No. :',
                                        controller: _phoneController,
                                        txtinp: TextInputType.phone,
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
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SmallButton2(
                                    function: () {
                                      _register();
                                    },
                                    title: 'SignUp',
                                  )),
                            ),
                            //SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account? Click here to ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: const Text(
                                  'SignIn',
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

                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
