import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/Domain/core/api_end_points.dart';
import 'package:netflix/application/search/search_bloc.dart';

import 'package:netflix/core/constants.dart';

import 'package:netflix/presentation/search/widgets/title.dart';

import '../../../core/colors/colors.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    log('idle search build');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text('Error while getting data'),
                );
              } else if (state.idleList.isEmpty) {
                const Center(
                  child: Text('data is empty'),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final movie = state.idleList[index];
                  return TopSearchItemTile(
                      title: movie.title ?? 'title not provided',
                      imageUrl: '$imageAppendUrl${movie.posterPath}');
                },
                separatorBuilder: (context, index) => kHeight20,
                itemCount: state.idleList.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width.w;
    return Row(
      children: [
        kWidth,
        Container(
          width: screenWidth * 0.4.w,
          height: 100.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        kWidth,
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                color: kWhiteColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        CircleAvatar(
          backgroundColor: kWhiteColor,
          radius: 28.r,
          child: CircleAvatar(
            radius: 26.r,
            backgroundColor: kBlackColor,
            child: Icon(
              Icons.play_arrow,
              size: 35.sp,
              color: kWhiteColor,
            ),
          ),
        ),
        kWidth,
      ],
    );
  }
}
