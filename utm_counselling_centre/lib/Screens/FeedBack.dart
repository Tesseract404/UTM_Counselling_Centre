import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Models/ReviewModel.dart';
 import '../Constants/AppColors.dart';
 import '../Firebase Authentication/firebase_auth_services.dart';
import '../Widgets/Buttons/SubmitButton.dart';
import '../Widgets/FeedBackItem.dart';
import '../Widgets/ScreenHeader.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  List<String?> selectedOptions = [];
  bool allQuestionsAnswered = false;
  Map<int, double> ratings = {};
  String? counsellor;
  String? awareness1;
  String? awareness2;
  String? knowledge1;
  String? knowledge2;
  String? skill1;
  String? skill2;
  final firebaseAuthService _auth = firebaseAuthService();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    counsellor = ModalRoute.of(context)?.settings.arguments as String?;
  }
  void _checkAllQuestionsAnswered() {
    setState(() {
      allQuestionsAnswered = selectedOptions.every((option) => option != null);
    });
  }

  void _submitReview() async {
    try {
      await _auth.submitReview(ReviewModel(
        counsellor: counsellor,
        notify: false,
        awareness1: awareness1,
        awareness2: awareness2,
        knowledge1: knowledge1,
        knowledge2: knowledge2,
        skill1: skill1,
        skill2: skill2,
      ));
      //print('im here');
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < questions.length; i++) {
       //selectedOptions.add(null);
      ratings[i] = 0;
    }
  }

  List<Map<String, dynamic>> questions = [
    {
      'question':
          '1. (Awareness) The session helped you understand the issue, opportunity, or problem more fully. ',
    },
    {
      'question':
          '2 (Awareness) The interviewer listened to you. You felt heard. ',
    },
    {
      'question':
          '3. (Knowledge You gained a better understandingof youself today.',
    },
    {
      'question':
          '4. (Knowledge You eared about diferent ways to address your issue, opportunity, or problem. ',
    },
    {
      'question':
          '5: (Skills) This interview helped you identify specific strengths and resources you have to help you work though your concerns and issues. ',
    },
    {
      'question':
          '6. (Skills) You will take action and do something in terms of chaning your thinking, feeling, or behavior after this session.  ',
    },
  ];
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        elevation: 0,
         automaticallyImplyLeading: false,
        title: const ScreenHeader(title: 'FeedBack',home: true,),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              const Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Text(
                'Instructions:',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.5,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
              child: Text(
                " Rate each statement on a 6-point scale where 1 = strongly disagree. 6 = strongly agree, and neutral You and your instructor may wish to change and adapt this form to meet he needs of varying clients agencies, and stations.",
                style: TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 11.34,
                ),
              ),
            ),
            Expanded(
              child: Container(
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.sGreyColor
                ),
                child:  ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return FeedBackItem(
                      question: questions[index]['question'],
                      initialRating: ratings[index]!,
                      onChanged: (rating) {
                        setState(() {
                          //selectedOptions[index] = rating;
                          ratings[index] = double.parse(rating!);
                          _checkAllQuestionsAnswered();
                          switch(index){
                            case 0:{
                              awareness1=rating;
                            }break;
                            case 1:{
                              awareness2=rating;
                            }break;
                            case 2:{
                              knowledge1=rating;
                            }break;
                            case 3:{
                              knowledge2=rating;
                            }break;
                            case 4:{
                              skill1=rating;
                            }break;
                            case 5:{
                              skill2=rating;
                            }break;

                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubmitButton(
                  color: allQuestionsAnswered ? AppColors.secondaryColor: AppColors.secondaryTextColor,
                  title: 'Submit',
                  route: '',
                  onTap: allQuestionsAnswered ?() {
                    _submitReview();
                     Navigator.popAndPushNamed(context, '/dash');
                  }:null,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
