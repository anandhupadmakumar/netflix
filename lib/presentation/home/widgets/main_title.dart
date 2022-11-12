import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/core/colors/colors.dart';

class MainTitleWidget extends StatelessWidget {
  final String title;
  const MainTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        title,
        style: TextStyle(
            color: kWhiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
