import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/failures/main_failure.dart';
import 'package:netflix/Domain/hot_and_new/hot_and_new_service.dart';

import '../../Domain/hot_and_new/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //on event get home screen datas
    on<GetHomeScreenData>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true, hasError: false));
        //send loading to ui

        //get Data
        final _movieResult = await _homeService.getHotAndNewMovieData();
        final _tvResult = await _homeService.getHotAndNewTvData();

        // transform data
        final _state1 = _movieResult.fold((MainFailure failure) {
          return HomeState(
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramaMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        }, (HotAndNewResp resp) {
          final pastYear = resp.results;
          final trending = resp.results;
          final tenseDrama = resp.results;
          final southIndian = resp.results;

          pastYear.shuffle();
          trending.shuffle();
          tenseDrama.shuffle();
          southIndian.shuffle();
          return HomeState(
            pastYearMovieList: pastYear,
            trendingMovieList: trending,
            tenseDramaMovieList: tenseDrama,
            southIndianMovieList: southIndian,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false,
          );
        });
        emit(_state1);
        final _state2 = _tvResult.fold((MainFailure failurre) {
          return HomeState(
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramaMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        }, (HotAndNewResp resp) {
          final trendingTv = resp.results;
          trendingTv.shuffle();
          return HomeState(
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: state.trendingMovieList,
            tenseDramaMovieList: state.tenseDramaMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: trendingTv,
            isLoading: false,
            hasError: false,
          );
        });
        emit(_state2);
      },
    );
  }
}
