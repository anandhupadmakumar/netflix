import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import 'main_CustomIconButton.dart';

class MainBackgroundCard extends StatelessWidget {
  const MainBackgroundCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600.h,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: const NetworkImage(imageUrlHome),),),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CustomIconButtonWidget(
                title: 'My List',
                icon: Icons.add,
              ),
              _PlayButton(),
              CustomIconButtonWidget(icon: Icons.info, title: 'Info')
            ],
          ),
        ),
      ],
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kWhiteColor),
      ),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        size: 30,
        color: kBlackColor,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          'Play',
          style: TextStyle(fontSize: 17, color: kBlackColor),
        ),
      ),
    );
  }
}
