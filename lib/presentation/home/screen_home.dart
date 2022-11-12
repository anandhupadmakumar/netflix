import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/catagories_home.dart';

import 'package:netflix/presentation/home/widgets/main_title_card.dart';
import 'package:netflix/presentation/home/widgets/main_number_card.dart';

import 'widgets/main_background_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (BuildContext context, index, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  print(direction);
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  print(scrollNotifier.value);
                  return true;
                },
                child: Stack(
                  children: [
                    // if (state.isLoading) {
                    //   return const Center(
                    //     child: CircularProgressIndicator(
                    //       strokeWidth: 2,
                    //     ),
                    //   );
                    // } else if (state.hasError) {
                    //   return const Center(
                    //       child: Text(
                    //     'Error while loading data',
                    //     style: TextStyle(color: kWhiteColor),
                    //   ));
                    // }
                    // final releasePastYear = state.pastYearMovieList.map(
                    //   (m) {
                    //     return '$imageAppendUrl${m.posterPath}';
                    //   },
                    // ).toList();
                    // //popular on network
                    // final popularOnNerWork = state.trendingMovieList.map(
                    //   (m) {
                    //     return '$imageAppendUrl ${m.posterPath}';
                    //   },
                    // ).toList();
                    // // trending now movie list
                    // final trending = state.pastYearMovieList.map(
                    //   (m) {
                    //     return '$imageAppendUrl ${m.posterPath}';
                    //   },
                    // ).toList();
                    // print(' trending list length ${trending.length.toString()}');
                    // //

                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        } else if (state.hasError) {
                          return const Center(
                              child: Text(
                            'Error while loading data',
                            style: TextStyle(color: kWhiteColor),
                          ));
                        }
                        final releasePastYear = state.pastYearMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        releasePastYear.shuffle();
                        //popular on network
                        final popularOnNerWork = state.southIndianMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        popularOnNerWork.shuffle();
                        // trending now movie list
                        final trending = state.trendingMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        trending.shuffle();
                        final showsBasedOnbooks = state.tenseDramaMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        showsBasedOnbooks.shuffle();

                        final newReleases = state.southIndianMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        newReleases.shuffle();

                        final tvDrama = state.pastYearMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        tvDrama.shuffle();
                        final usMovie = state.southIndianMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        usMovie.shuffle();
                        final internationShows = state.trendingMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        internationShows.shuffle();
                        usMovie.shuffle();
                        final hindiMovieAndTv = state.southIndianMovieList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        hindiMovieAndTv.shuffle();

                        final top10IndiaToday = state.trendingTvList.map(
                          (m) {
                            return '$imageAppendUrl${m.posterPath}';
                          },
                        ).toList();
                        top10IndiaToday.shuffle();

                        print(
                            ' trending list length ${releasePastYear.length.toString()}');
                        //
                        return ListView(
                          children: [
                            MainBackgroundCard(),
                            MainTitleCardWidget(
                              posterList: releasePastYear,
                              title: 'Continue Watching for Nivea C M',
                            ),
                            MainTitleCardWidget(
                              posterList: popularOnNerWork,
                              title: 'Popular on Netflix',
                            ),
                            MainTitleCardWidget(
                              posterList: trending,
                              title: 'Trending Now',
                            ),
                            MainTitleCardWidget(
                              posterList: showsBasedOnbooks,
                              title: ' TV Shows Based on Books',
                            ),
                            MainTitleCardWidget(
                              posterList: newReleases,
                              title: 'New Releases ',
                            ),
                            MainTitleCardWidget(
                              posterList: tvDrama,
                              title: 'TV Dramas ',
                            ),
                            MainNumberCardWidget(
                              postersList: top10IndiaToday,
                            ),
                            MainTitleCardWidget(
                              posterList: usMovie,
                              title: 'US Movies ',
                            ),
                            MainTitleCardWidget(
                              posterList: hindiMovieAndTv,
                              title: 'Hindi Movies & TV ',
                            ),
                            MainTitleCardWidget(
                              posterList: internationShows,
                              title: 'International TV shows ',
                            ),
                          ],
                        );
                      },
                    ),

                    scrollNotifier.value == true
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                              width: double.infinity,
                              height: 118.h,
                              color: Colors.black.withOpacity(0.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                          'https://pngimg.com/uploads/netflix/netflix_PNG8.png',
                                          width: 50,
                                          height: 50),
                                      const Spacer(),
                                      const Icon(
                                        Icons.cast,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      kWidth,
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/ntflixAvat.jpg'))),
                                      ),
                                      kWidth,
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('TV Shows'),
                                      Text('Movies'),
                                      Row(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const DropDownListWidget();
                                                },
                                              );
                                            },
                                            label: const Icon(
                                              Icons.arrow_drop_down,
                                              color: kWhiteColor,
                                            ),
                                            icon: const Text(
                                              "Categories",
                                              style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            // icon: const Icon(Icons.arrow_drop_down),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : kHeight,
                  ],
                ),
              );
            }),
      ),
    );
  }
}
