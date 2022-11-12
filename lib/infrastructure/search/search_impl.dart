import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/search/model/search_respo/search_respo.dart';
import 'package:netflix/Domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/Domain/search/search_service.dart';

import '../../Domain/core/api_end_points.dart';

@LazySingleton(as: SearchService)
class SearchImpl implements SearchService {
  @override
  Future<Either<MainFailure, SearchRespo>> searchMovies(
      {required String movieQuery}) async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.search,
        queryParameters: {
          'query': movieQuery,
        },
      );
      log('$movieQuery the movie query');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 422) {
        final result = SearchRespo.fromJson(response.data);
        log('call avrundoooo');
        return right(result);
      } else {
        return const Left(MainFailure.clientFailure());
      }
    } catch (e) {
      log('$e tis is dio error');
      log('$movieQuery the movie query');
      return const Left(MainFailure.clientFailure());
    }
  }
}
