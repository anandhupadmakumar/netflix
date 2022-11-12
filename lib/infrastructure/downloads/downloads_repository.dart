import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/api_end_points.dart';
import 'package:netflix/Domain/downloads/models/downloads.dart';

import 'package:netflix/Domain/core/failures/main_failure.dart';

import 'package:dartz/dartz.dart';

import '../../Domain/downloads/idownloads_repo.dart';

@LazySingleton(as: IDownloadsRepos)
class DonwnloadsRepository implements IDownloadsRepos {
  @override
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.downloads);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final downloadList = (response.data['results'] as List).map((e) {
          return Downloads.fromJson(e);
        }).toList();

        print(downloadList);
        return right(downloadList);
      } else {
        return const Left(MainFailure.clientFailure());
      }
    } catch (_) {
      return const Left(MainFailure.clientFailure());
    }
  }
}
