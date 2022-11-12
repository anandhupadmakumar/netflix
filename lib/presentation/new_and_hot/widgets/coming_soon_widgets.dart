import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/main_CustomIconButton.dart';
import '../../widgets/video_frame_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          StickyHeader(
            header: Column(
              children: [
                Text(
                  month,
                  style: const TextStyle(
                      color: kColorGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  day,
                  style: const TextStyle(
                      letterSpacing: 5,
                      color: kWhiteColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            content: SizedBox(
              height: 350.h,
              width: 50.w,
            ),
          ),
          SizedBox(
            width: size - 50.w,
            height: 400.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VideoFrameWidget(
                  imgUrl: posterPath,
                ),
                kHeight,
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        maxLines: 1,
                        softWrap: true,
                        movieName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    const CustomIconButtonWidget(
                      icon: Icons.notifications,
                      title: 'remind me',
                      iconSize: 20,
                      textSize: 10,
                    ),
                    kWidth,
                    const CustomIconButtonWidget(
                      icon: Icons.info,
                      title: 'Info',
                      iconSize: 20,
                      textSize: 10,
                    ),
                    kWidth,
                  ],
                ),
                Text("Coming on '$month - $day"),
                kHeight,
                Text(
                  maxLines: 1,
                  movieName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                kHeight,
                Text(
                  maxLines: 4,
                  description,
                  style: const TextStyle(color: kColorGrey),
                ),
                kHeight,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
