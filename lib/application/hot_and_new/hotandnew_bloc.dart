import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/failures/main_failure.dart';
import 'package:netflix/Domain/hot_and_new/hot_and_new_service.dart';

import '../../Domain/hot_and_new/model/hot_and_new_resp.dart';

part 'hotandnew_event.dart';
part 'hotandnew_state.dart';
part 'hotandnew_bloc.freezed.dart';

@injectable
class HotandnewBloc extends Bloc<HotandnewEvent, HotandnewState> {
  final HotAndNewService _hotAndNewService;
  HotandnewBloc(this._hotAndNewService) : super(HotandnewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      // send loading to ui
      emit(
        const HotandnewState(
          comingSoonList: [],
          everyoneIsWatching: [],
          isLoading: true,
          hasError: false,
        ),
      );

      //get hot and new movie data
      final _result = await _hotAndNewService.getHotAndNewMovieData();
      final newState = _result.fold((MainFailure failure) {
        return const HotandnewState(
          comingSoonList: [],
          everyoneIsWatching: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        return HotandnewState(
          comingSoonList: resp.results,
          everyoneIsWatching: state.everyoneIsWatching,
          isLoading: false,
          hasError: false,
        );
      });
      emit(newState);
    });

    // get hot and new tv data

    on<LoadDataInEveryOneIsWatching>((event, emit) async {


      // send loading to ui
      emit(
        const HotandnewState(
          comingSoonList: [],
          everyoneIsWatching: [],
          isLoading: true,
          hasError: false,
        ),
      );

      //get hot and new movie data
      final _result = await _hotAndNewService.getHotAndNewTvData();
      final newState = _result.fold((MainFailure failure) {
        return const HotandnewState(
          comingSoonList: [],
          everyoneIsWatching: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        return HotandnewState(
          comingSoonList: state.comingSoonList,
          everyoneIsWatching:resp.results ,
          isLoading: false,
          hasError: false,
        );
      });
      emit(newState);
      
    });
  }
}
