import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/AppColors.dart';
class ScreenHeader extends StatelessWidget {
  final title;
  final bool home;
  const ScreenHeader({Key? key, this.title, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 9,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(90, 50, 0, 20),
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  fontFamily: GoogleFonts.oswald().fontFamily,
                ),
              ),
            ),
          ),
        ),
        Expanded(flex: 2,
          child: home? IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/dash');
            },
            icon: const Icon(
              Icons.home_rounded,
              color: AppColors.tertiaryColor,
              size: 30,
            ),
          ):const SizedBox(),
        ),

      ],
    );
  }
}
