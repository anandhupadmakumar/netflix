import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netflix/core/colors/colors.dart';

import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

import '../../application/hot_and_new/hotandnew_bloc.dart';
import '../../core/constants.dart';

import 'widgets/coming_soon_widgets.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              kWidth,
              Text(
                'Hot & New',
                style: GoogleFonts.archivoBlack(fontSize: 30),
              ),
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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/ntflixAvat.jpg'))),
              ),
              kWidth,
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: kBlackColor,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelColor: kWhiteColor,
            indicator:
                BoxDecoration(color: kWhiteColor, borderRadius: kRadius20),
            tabs: const [
              Tab(
                text: '🍟 Coming Soon',
              ),
              Tab(
                text: "👀 Everyone's Watching",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ComingSoonList(
              key: Key('coming_soon'),
            ),
            EveryoneIsWatchingList(key: Key('everyone_is_watching')),
          ],
        ),
      ),
    );
  }

  // Widget _buildComingSoon(context) {
  //   return ListView.separated(
  //       itemBuilder: (context, index) => const ComingSoonWidget(),
  //       separatorBuilder: (context, index) => kHeight,
  //       itemCount: 10);
  // }

//   Widget _buildEveryonesWatching() {
//     return ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         itemBuilder: (context, index) {
//           return const SizedBox();
//         },
//         separatorBuilder: (context, index) => kHeight,
//         itemCount: 10);
//   }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
    );
    return RefreshIndicator(
      onRefresh: () async {
        return BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('error while loading coming soon data'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('data is empty'),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }

                final _date = DateTime.parse(movie.releaseDate!);
                final formattedDate = DateFormat.yMMMMd('en_US').format(_date);

                return ComingSoonWidget(
                  id: movie.id.toString(),
                  month: formattedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase(),
                  day: movie.releaseDate!.split('-')[2],
                  posterPath: '$imageAppendUrl${movie.posterPath}',
                  movieName: movie.originalTitle ?? 'title not available',
                  description: movie.overview ?? 'description is not available',
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 5,
              ),
              itemCount: state.comingSoonList.length,
            );
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
    );
    return RefreshIndicator(
      onRefresh: () async {
        return BlocProvider.of<HotandnewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
      child: BlocBuilder<HotandnewBloc, HotandnewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('error while loading coming soon data'),
            );
          } else if (state.everyoneIsWatching.isEmpty) {
            return const Center(
              child: Text('data is empty'),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                final movie = state.everyoneIsWatching[index];
                if (movie.id == null) {
                  return const SizedBox();
                }

                final tv = state.everyoneIsWatching[index];

                return EveryonesWatchingWidget(
                  posterPath: '$imageAppendUrl${tv.posterPath}',
                  movieName: tv.originalName ?? 'No name provided',
                  description: tv.overview ?? 'No description ',
                );
              },
              separatorBuilder: (context, index) => kHeight,
              itemCount: state.everyoneIsWatching.length,
            );
          }
        },
      ),
    );
  }
}
