import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/main_card.dart';
import 'package:netflix/presentation/home/widgets/main_title.dart';

class MainTitleCardWidget extends StatelessWidget {
  final String title;
  final List<String> posterList;
  const MainTitleCardWidget({
    Key? key,
    required this.title,
    required this.posterList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: title),
          kHeight,
          LimitedBox(
            maxHeight: 150.h,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return MainCardWidget(
                    imageUrl: posterList[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return kWidth;
                },
                itemCount: posterList.length),
          )
        ],
      ),
    );
  }
}
