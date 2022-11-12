import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/Domain/downloads/models/downloads.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({Key? key}) : super(key: key);
  final _widgetList = [
    const _SmartWidgetDownloads(),
    Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarWidget(
          title: 'Downloads',
        ),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: ((context, index) => _widgetList[index]),
          separatorBuilder: ((context, index) => SizedBox(
                height: 30.h,
              )),
          itemCount: _widgetList.length),
    );
  }
}

class _SmartWidgetDownloads extends StatelessWidget {
  const _SmartWidgetDownloads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth,
        Text(
          'Smart Downloads',
          style: TextStyle(fontSize: 16.sp),
        )
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {Key? key,
      required this.image,
      this.angle = 0,
      required this.margin,
      required this.size})
      : super(key: key);

  final String image;
  final double angle;
  final EdgeInsets margin;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5).r,
            image:
                DecorationImage(fit: BoxFit.cover, image: NetworkImage(image))),
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  Section2({Key? key}) : super(key: key);
  // final imageList = [
  //   'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/61PVJ06oecwvcBisoAQu6SDfdcS.jpg',
  //   'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xGeiFP4C21jiZWLpPpPCg3XjGdD.jpg',
  //   'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/u0XUBNQWlOvrh0Gd97ARGpIkL0.jpg'
  // ];

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImages());
    });
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          'Introducing Downloads for you',
          style: TextStyle(
              color: kWhiteColor, fontSize: 23.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        kHeight,
        Text(
            "We will download a personalized selection of \n movies and shows for you, So there'sm \n always something watch on yours\n device",
            style: TextStyle(color: Colors.grey, fontSize: 16.sp),
            textAlign: TextAlign.center),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (ctx, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoding || state.downloads.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            radius: size.width * 0.35,
                          ),
                        ),
                        DownloadsImageWidget(
                          image:
                              "$imageAppendUrl${state.downloads[0].posterPath}",
                          margin: const EdgeInsets.only(left: 160, bottom: 20),
                          angle: 15,
                          size: Size(size.width * 0.4, size.width * 0.5),
                        ),
                        DownloadsImageWidget(
                            image:
                                "$imageAppendUrl${state.downloads[1].posterPath}",
                            margin:
                                const EdgeInsets.only(right: 160, bottom: 20),
                            angle: -15,
                            size: Size(size.width * 0.4, size.width * 0.5)),
                        DownloadsImageWidget(
                            image:
                                "$imageAppendUrl${state.downloads[2].posterPath}",
                            margin: const EdgeInsets.only(left: 0, bottom: 0),
                            size: Size(size.width * 0.4, size.width * 0.55)),
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8).r),
            color: kButtonColorBlue,
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'set up',
                style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8).r),
          color: kButtonColorWhite,
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'See what you can download',
              style: TextStyle(
                  color: kBlackColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
