import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/colors.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double iconSize;
  final double textSize;
  const CustomIconButtonWidget(
      {Key? key,
      required this.icon,
      required this.title,
      this.iconSize = 30,
      this.textSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: iconSize.sp,
          color: kWhiteColor,
        ),
        Text(
          title,
          style: TextStyle(color: kWhiteColor, fontSize: textSize.sp),
        ),
      ],
    );
  }
}
