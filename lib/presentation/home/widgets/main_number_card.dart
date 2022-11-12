import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants.dart';
import 'main_card.dart';
import 'main_title.dart';
import 'number_card.dart';

class MainNumberCardWidget extends StatelessWidget {
  final List<String> postersList;
  const MainNumberCardWidget({
    Key? key,
    required this.postersList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitleWidget(title: 'Top 10 in India Today'),
        kHeight,
        LimitedBox(
          maxHeight: 150.h,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return NumberCardWidget(
                  index: index,
                  imageUrl: postersList[index],
                );
              },
              separatorBuilder: (context, index) {
                return kWidth;
              },
              itemCount: postersList.length),
        )
      ],
    );
  }
}
