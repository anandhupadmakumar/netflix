import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/core/colors/colors.dart';

import '../../core/constants.dart';

class VideoFrameWidget extends StatelessWidget {
  final String imgUrl;
  const VideoFrameWidget({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200.h,
          child: Image.network(
            imgUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child:  CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.wifi_off_rounded,
                  color: kWhiteColor,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 5.h,
          right: 5.w,
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            radius: 22.r,
            child: IconButton(
              onPressed: (() {}),
              icon: Icon(
                Icons.volume_off,
                size: 20.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
