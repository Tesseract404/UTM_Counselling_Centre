import 'package:flutter/material.dart';
class QuesCard extends StatelessWidget {
  final String question;
  final List<String> options;
  final List<bool> isSelected;
  final ValueChanged  onOptionSelected;
  const QuesCard({Key? key, required this.question, required this.options, required this.isSelected, required this.onOptionSelected   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Thoughts that you would be better off dead or of hurting yourself in some way',
          style: TextStyle(
             fontWeight: FontWeight.w600,
            fontSize: 16,
           ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffFFF6D8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    question,
                  ),
                  const SizedBox(height: 12.0),
                  Column(
                    children: List.generate(options.length, (index) {
                      return ListTile(
                        title: Text(options[index]),
                        leading: Checkbox(
                          value: isSelected[index],
                          onChanged: (bool? value) {
                            onOptionSelected(index);
                          },
                        ),
                      );
                    }),
                  ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
