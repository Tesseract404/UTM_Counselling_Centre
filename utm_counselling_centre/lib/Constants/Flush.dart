import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'AppContext.dart'; // Import your AppContext class

class Flush {
  static void showFlushBar(String message, {Color? backgroundColor}) {
    final BuildContext? context = AppContext.navigatorKey.currentContext;
    if (context != null) {
      backgroundColor ??= AppColors.textColor.withOpacity(0.7); // Default color with opacity

      Flushbar(
        messageText: Center(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        flushbarPosition: FlushbarPosition.BOTTOM,
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        duration: const Duration(seconds: 2),
        borderRadius: BorderRadius.circular(23),
        reverseAnimationCurve: Curves.easeInOut,
      ).show(context);
    } else {
      print('Error: No valid context found to show FlushBar.');
    }
  }
}
