import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Constants/AppColors.dart';
class FeedBackItem extends StatefulWidget {
  final String question;
  final initialRating ;
  final ValueChanged<String?> onChanged;

  const FeedBackItem({
    Key? key,

    required this.question,
    required this.onChanged,
    required this.initialRating,
  }) : super(key: key);

  @override
  _FeedBackItemState createState() => _FeedBackItemState();
}

class _FeedBackItemState extends State<FeedBackItem> {
   int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                widget.question,
                style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: RatingBar.builder(
              glow: false,
              initialRating: widget.initialRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 6,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return const Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return const Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return const Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return const Icon(
                      Icons.sentiment_satisfied_alt,
                      color: Colors.green,
                    );
                  case 5:
                    return const Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.greenAccent,
                    );
                  default:
                    return const SizedBox();
                }
              },
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating.toInt();
                });
                widget.onChanged(rating.toInt().toString());
                 print(_rating);
              },
            ),
          ),
        ],
      ),
    );
  }
}

