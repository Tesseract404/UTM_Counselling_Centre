import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/ConfirmButton.dart';
import 'package:utm_counselling_centre/Widgets/Buttons/NormalButton.dart';

import '../Widgets/Buttons/SmallButton.dart';


class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
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

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < questions.length; i++) {
      selectedOptions.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Short Quiz',
            style: TextStyle(
              color: Color(0xff5D3392),
              fontWeight: FontWeight.w600,
              fontSize: 38,
              fontFamily: GoogleFonts.oswald().fontFamily,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
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

                            style:
                                TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffFFF6D8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                questions[index]['question'],
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  questions[index]['options'].length,
                                  (optionIndex) {
                                    final option =
                                        questions[index]['options'][optionIndex];
                                    return RadioListTile<String?>(
                                      activeColor: Color(0xff811DFF),
                                      title: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      value: option,
                                      groupValue: selectedOptions[index],
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedOptions[index] = value;
                                        });
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
           child: NormalButton(color: Color(0xff5D3392),title: 'Submit',route: '',),
         ),
        ],
      ),
       
    );
  }
}
