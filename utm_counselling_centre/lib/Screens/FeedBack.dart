import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 import '../Constants/AppColors.dart';
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
  void _checkAllQuestionsAnswered() {
    setState(() {
      allQuestionsAnswered = selectedOptions.every((option) => option != null);
    });
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
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        title: const ScreenHeader(title: 'FeedBack',home: true,),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
              child: Row(
                children: const [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: Text(
                        'Name of Interviewer: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                      child: TextField(),
                    ),
                  )
                ],
              ),
            ),
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
                  color: AppColors.textColor,
                  fontSize: 15,
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
