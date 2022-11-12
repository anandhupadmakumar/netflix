import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix/Domain/downloads/idownloads_repo.dart';

import '../../Domain/core/failures/main_failure.dart';
import '../../Domain/downloads/models/downloads.dart';
part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepos downloadsRepos;
  DownloadsBloc(this.downloadsRepos) : super(DownloadsState.initial()) {
    on<DownloadsEvent>((event, emit) async {
      emit(
        state.copyWith(
          isLoding: true,
          downloadsFailureOrSuccessOption: none(),
        ),
      );
      final Either<MainFailure, List<Downloads>> downloadOptions =
          await downloadsRepos.getDownloadsImages();
      emit(
        downloadOptions.fold(
          (failure) => state.copyWith(
              isLoding: false,
              downloadsFailureOrSuccessOption: Some(left(failure))),
          (success) => state.copyWith(
              isLoding: false,
              downloads: success,
              downloadsFailureOrSuccessOption: Some(right(success))),
        ),
      );
    });
  }
}
