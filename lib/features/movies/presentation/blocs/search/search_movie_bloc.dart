import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdb_movies/core/constants/constants.dart';
import 'package:tmdb_movies/core/enums/status.dart';
import 'package:tmdb_movies/core/states/data_state.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';
import 'package:tmdb_movies/features/movies/domain/use_cases/search_movie.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovieUseCase _searchMovieUseCase;

  SearchMovieBloc(this._searchMovieUseCase) : super(SearchMovieState.initial()) {
    on<SearchMovie>(
      onSearchMovie,
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(milliseconds: 300)).asyncExpand(mapper),
    );
  }

  void onSearchMovie(SearchMovie event, Emitter<SearchMovieState> emit) async {
    if (event.query.isEmpty) {
      emit(SearchMovieState.initial());
      return;
    }

    emit(state.copyWith(status: Status.loading));

    final dataState = await _searchMovieUseCase(
      params: SearchMovieUseCaseParams(query: event.query, page: state.pageNumber + 1),
    );

    // show loading
    await Future.delayed(const Duration(milliseconds: 500));

    switch (dataState) {
      case DataSuccess _:
        // Check pagination
        final movies = (event.query == state.query)
            ? [state.movies, dataState.data!].expand((x) => x).toList()
            : dataState.data!;
        final pageNumber = (event.query == state.query) ? state.pageNumber + 1 : 1;

        emit(
          state.copyWith(
            query: event.query,
            movies: movies,
            status: Status.success,
            pageNumber: pageNumber,
            isLastPage: dataState.data!.length != numberOfMoviesPerRequest,
          ),
        );
      case DataFailed _:
        emit(state.copyWith(error: dataState.error?.message, status: Status.failure));
    }
  }
}
