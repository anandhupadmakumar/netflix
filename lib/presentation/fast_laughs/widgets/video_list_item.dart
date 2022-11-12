import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/Domain/downloads/models/downloads.dart';
import 'package:netflix/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItemInhertedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInhertedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInhertedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInhertedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInhertedWidget>();
  }
}

class VideoListItemWidget extends StatelessWidget {
  final int index;
  const VideoListItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInhertedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool value) {},
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Left side of the screen
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 30.r,
                  child: IconButton(
                    onPressed: (() {}),
                    icon: Icon(
                      Icons.volume_off,
                      size: 30.sp,
                    ),
                  ),
                ),
                // Right side of the screen
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30.r,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendUrl$posterPath'),
                      ),
                    ),
                    const VideoIconsWidgets(
                      icon: Icons.emoji_emotions,
                      title: 'LOL',
                    ),
                    const VideoIconsWidgets(
                      icon: Icons.add,
                      title: 'My List',
                    ),
                    GestureDetector(
                      onTap: () async {
                        final moviName = VideoListItemInhertedWidget.of(context)
                            ?.movieData
                            .posterPath;
                        if (moviName != null) {
                          await Share.share(moviName);
                        }
                      },
                      child: const VideoIconsWidgets(
                        icon: Icons.share,
                        title: 'Share',
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                      
                      },
                      child: const VideoIconsWidgets(
                        icon: Icons.play_arrow,
                        title: 'play',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoIconsWidgets extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoIconsWidgets({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
      child: Column(
        children: [
          Icon(
            icon,
            color: kWhiteColor,
            size: 40.sp,
          ),
          Text(
            title,
            style: TextStyle(color: kWhiteColor, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  void Function(bool isPlaying) onStateChanged;
  FastLaughVideoPlayer(
      {Key? key, required this.videoUrl, required this.onStateChanged})
      : super(key: key);

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}


class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);

      setState(() {
    
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        fit: BoxFit.cover,
        child: SizedBox(
          width: _videoPlayerController.value.size.width,
          height: _videoPlayerController.value.size.height,
          child: _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.size.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
        ),
      ),
    );

    // return SizedBox(
    //   width: double.infinity,
    //   height: double.infinity,
    //   child: _videoPlayerController.value.isInitialized
    //       ? AspectRatio(
    //           aspectRatio:_videoPlayerController.value.size.aspectRatio ,
    //           child: VideoPlayer(_videoPlayerController),
    //         )
    //       : Center(
    //           child: CircularProgressIndicator(
    //             strokeWidth: 2,
    //           ),
    //         ),
    // );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
