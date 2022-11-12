import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/colors.dart';

class SearchTitle extends StatelessWidget {
  final String title;
  const SearchTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: kWhiteColor, fontSize: 22.sp, fontWeight: FontWeight.bold),
    );
  }
}
