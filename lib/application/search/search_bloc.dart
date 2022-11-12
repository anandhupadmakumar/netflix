import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/Domain/core/failures/main_failure.dart';
import 'package:netflix/Domain/downloads/idownloads_repo.dart';
import 'package:netflix/Domain/downloads/models/downloads.dart';
import 'package:netflix/Domain/search/search_service.dart';

import '../../Domain/search/model/search_respo/search_respo.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepos _downloadService;
  final SearchService _searchService;
  SearchBloc(this._searchService, this._downloadService)
      : super(SearchState.initial()) {
    //idle state
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(state);
        return;
      }
      emit(
        SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: true,
          isError: false,
        ),
      );
      // get trending
      final result = await _downloadService.getDownloadsImages();
      final _state = result.fold((MainFailure fail) {
        return const SearchState(
          searchResultList: [],
          idleList: [],
          isLoading: false,
          isError: true,
        );
      }, (List<Downloads> list) {
        return SearchState(
          searchResultList: [],
          idleList: list,
          isLoading: false,
          isError: false,
        );
      });

      // show to ui
      emit(_state);
    });

    // search result state

    on<SearchMovie>((event, emit) async {
      //call search movie api

      emit(
        SearchState(
          searchResultList: [],
          idleList: state.idleList,
          isLoading: true,
          isError: false,
        ),
      );

      final result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = result.fold(
        (MainFailure f) {
          return  SearchState(
            searchResultList: [],
            idleList: state.idleList,
            isLoading: false,
            isError: true,
          );
        },
        (SearchRespo r) {
          return SearchState(
            searchResultList: r.results,
            idleList: state.idleList,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(_state);

      // show to ui search result
    });
  }
}
