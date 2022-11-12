import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/main_CustomIconButton.dart';
import '../../widgets/video_frame_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryonesWatchingWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
         Text(
          movieName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        kHeight,
        Text(
          description,
          style: TextStyle(color: kColorGrey, fontSize: 13.sp),
        ),
        kHeight50,
          VideoFrameWidget(imgUrl: posterPath,),
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomIconButtonWidget(
              icon: Icons.share,
              title: 'Share',
              iconSize: 30.sp,
              textSize: 16.sp,
            ),
            kWidth,
            CustomIconButtonWidget(
              icon: Icons.add,
              title: 'Add',
              iconSize: 30.sp,
              textSize: 16.sp,
            ),
            kWidth,
            CustomIconButtonWidget(
              icon: Icons.play_arrow,
              title: 'Play',
              iconSize: 30.sp,
              textSize: 16.sp,
            ),
          ],
        ),
        kWidth,
      ],
    );
  }
}
