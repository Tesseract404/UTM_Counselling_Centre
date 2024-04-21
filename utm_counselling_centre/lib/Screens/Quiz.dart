import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/SubmitButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Firebase Authentication/firebase_auth_services.dart';
import '../Models/ReportsModel.dart';
import '../Widgets/Buttons/NormalButton.dart';
import '../Widgets/ScreenHeader.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final firebaseAuthService _auth = firebaseAuthService();
  late String counsellor;
  void _createReport() async {
    String content = 'It is recommended that Patient A attend regular therapy sessions to monitor his progress and make any necessary adjustments to his treatment plan. Close collaboration between the therapist, psychiatrist (if medication is prescribed), and any other healthcare professionals involved in his care is essential to ensure a comprehensive approach to his mental health.';
    String doctor = counsellor;
    try {
      await _auth.createReport(ReportModel(
        content: content,
        doctor: doctor,
        approved: false,
        notified: false,
      ));
      print('im here');
    } catch (e) {
      print(e);
    }
  }

  List<Map<String, dynamic>> questions = [
    {
      'thought':
          'Thoughts that you would be better off dead or of hurting yourself in some way',
      'question':
          'Over the last 2 weeks, how often have you been feeling this?',
      'options': [
        'Not at all',
        'Several days',
        'More than half the days',
        'Nearly every day'
      ],
    },
    {
      'thought':
          'Trouble concentrating on things, such as reading the newspaper or watching television',
      'question':
          'Over the last 2 weeks, how often have you been feeling this?',
      'options': [
        'Not at all',
        'Several days',
        'More than half the days',
        'Nearly every day'
      ],
    },
    {
      'thought': 'Trouble falling asleep, staying asleep, or sleeping too much',
      'question':
          'Over the last 2 weeks, how often have you been feeling this?',
      'options': [
        'Not at all',
        'Several days',
        'More than half the days',
        'Nearly every day'
      ],
    },
    {
      'thought': 'Not being able to stop or control worrying',
      'question':
          'Over the last 2 weeks, how often have you been feeling this?',
      'options': [
        'Not at all',
        'Several days',
        'More than half the days',
        'Nearly every day'
      ],
    },
    {
      'thought': 'Feeling down, depressed or hopeless',
      'question':
          'Over the last 2 weeks, how often have you been feeling this?',
      'options': [
        'Not at all',
        'Several days',
        'More than half the days',
        'Nearly every day'
      ],
    },
  ];
  List<String?> selectedOptions = [];
  bool allQuestionsAnswered = false;

  void _checkAllQuestionsAnswered() {
    setState(() {
      allQuestionsAnswered = selectedOptions.every((option) => option != null);
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < questions.length; i++) {
      selectedOptions.add(null);
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    counsellor = ModalRoute.of(context)?.settings.arguments as String? ?? 'Counsellor';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        title: const ScreenHeader(
          title: 'Short Quiz',
          home: false,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            questions[index]['thought'],
                            style: const TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffFFF6D8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                questions[index]['question'],
                                style: const TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  questions[index]['options'].length,
                                  (optionIndex) {
                                    final option = questions[index]['options']
                                        [optionIndex];
                                    return RadioListTile<String?>(
                                      activeColor: AppColors.primaryColor,
                                      title: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      value: option,
                                      groupValue: selectedOptions[index],
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedOptions[index] = value;
                                        });
                                        _checkAllQuestionsAnswered();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SubmitButton(
              color: allQuestionsAnswered
                  ? AppColors.secondaryColor
                  : AppColors.secondaryTextColor,
              title: 'Submit',
              route: '',
              onTap: allQuestionsAnswered
                  ? () {
                //print('working');
                      _createReport();
                      Navigator.popAndPushNamed(context, '/dash');
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
