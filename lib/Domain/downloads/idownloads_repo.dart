import 'package:dartz/dartz.dart';
import 'package:netflix/Domain/core/failures/main_failure.dart';
import 'package:netflix/Domain/downloads/models/downloads.dart';

abstract class IDownloadsRepos {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages();
}
