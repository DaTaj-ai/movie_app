

import 'package:flutter/cupertino.dart';
import 'package:movie_app/core/constants/app_colors.dart';

Widget NumberOverlay({required String number}) {
  return
    Positioned(
      top: 289.05,   // your given top position
      left: 24,      // your given left position
      child: SizedBox(
        width: 46.52,   // your given width
        height: 57.84,  // your given height
        child: FittedBox(
          child: Text(
            "1", // dynamic number here
            style: TextStyle(
              fontSize: 120, // large so FittedBox can scale it
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 0.5 // border width
                ..color = AppColors.myBlue, // border color
            ),
          ),
        ),
      ),
    );
}