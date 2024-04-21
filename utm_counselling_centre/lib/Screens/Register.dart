import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/SmallButton.dart';
import '../Widgets/FormFields.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
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
                                  color: Color(0xff5D3392),
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
                                  color: const Color(0xffF5F5F5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                                  child: Column(
                                    children: const [
                                      FormFields(title: 'Name :'),
                                      FormFields(title: 'UTMID :'),
                                      FormFields(title: 'Email :'),
                                      FormFields(title: 'Phone No. :'),
                                      FormFields(title: 'Password :'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SmallButton(
                                    title: 'SignUp',
                                    route: '/',
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
                              Text(
                                'Already have an account? Click here to ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  'SignIn',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Color(0xff811DFF),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
