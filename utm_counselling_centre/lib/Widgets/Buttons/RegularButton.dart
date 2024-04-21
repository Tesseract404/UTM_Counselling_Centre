import 'package:flutter/material.dart';
import 'package:utm_counselling_centre/Constants/AppColors.dart';

class RegularButton extends StatefulWidget {
  final String title;
  final String route;

  RegularButton({Key? key, required this.title, required this.route}) : super(key: key);

  @override
  _RegularButtonState createState() => _RegularButtonState();
}

class _RegularButtonState extends State<RegularButton> {
  bool _isClicked = false;

  void _toggleButtonColor() {
    setState(() {
      _isClicked = !_isClicked;
    });

    Navigator.popAndPushNamed(context, widget.route);
  }

  @override
  Widget build(BuildContext context) {
    Color currentBackgroundColor = _isClicked ? AppColors.primaryColor : AppColors.whiteColor;
    Color currentBorderColor = _isClicked ? AppColors.whiteColor : AppColors.primaryColor;
    Color currentTextColor = _isClicked ? AppColors.whiteColor : AppColors.primaryColor;

    return GestureDetector(
      onTap: _toggleButtonColor,
      child: Container(
        height: 40,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: currentBorderColor),
          borderRadius: BorderRadius.circular(23),
          color: currentBackgroundColor,
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: currentTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
