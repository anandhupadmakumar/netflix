import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/core/colors/colors.dart';

import '../../../core/constants.dart';

class NumberCardWidget extends StatelessWidget {
  final int index;
  final String imageUrl;
  const NumberCardWidget({
    Key? key,
    required this.index,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 33.w,
              height: 150.h,
            ),
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: kRadius,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 40,
          left: 10,
          child: BorderedText(
            strokeColor: kWhiteColor,
            strokeWidth: 4.0,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                  fontSize: 90,
                  color: kBlackColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.anton().fontFamily,
                  decoration: TextDecoration.none),
            ),
          ),
        )
      ],
    );
  }
}
