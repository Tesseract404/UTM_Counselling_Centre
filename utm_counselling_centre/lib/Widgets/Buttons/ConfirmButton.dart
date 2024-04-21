import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/SmallButton.dart';
class ConfirmButton extends StatelessWidget {
  final title;
   final Color color;

  const ConfirmButton({Key? key, this.title,   required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {if(title!='Cancel') {
          Navigator.pop(context);
          showDialog<void>(
            context: context,
            //barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                title: const Center(
                  child: Text(
                    'A Quick Test Before Consultation',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: SmallButton ( title: 'Go to Quiz' , route: '/quiz',
                            ),
                          )
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffD9D9D9),
                          ),
                          child: Column(
                            children:const [
                               Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    'Why is this test?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Color(0xff8C8C8C)
                                    ),
                                  ),
                                ),
                              ),Center(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 3,5, 5),
                                  child: Text(
                                      "This small test is obviously for your better treatment.Basically by this we get a brief idea about your current state.We take you through this little test just to help our doctorsand counselors to know about you and your state beforethey meet you in person. We care about yourprivacy and assure you that youranswers will be confidential at any cost.Thank you and Good luck" ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Color(0xff8C8C8C)
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        else {
            Navigator.pop(context);
          }
        },
        child: Container(
          // height: 50,
            width: 145,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:color    ,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 10),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
