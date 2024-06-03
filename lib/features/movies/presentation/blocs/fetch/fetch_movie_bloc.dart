import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/core/constants/constants.dart';
import 'package:tmdb_movies/core/enums/index.dart';
import 'package:tmdb_movies/core/states/data_state.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';
import 'package:tmdb_movies/features/movies/domain/use_cases/get_movie_list.dart';

part 'fetch_movie_event.dart';
part 'fetch_movie_state.dart';

class FetchMovieBloc extends Bloc<FetchMovieEvent, FetchMovieState> {
  final GetMovieListUseCase _getMovieListUseCase;

  FetchMovieBloc(this._getMovieListUseCase) : super(FetchMovieState.initial()) {
    on<FetchMovie>(onFetchMovie);
    on<SelectRatingCategory>(onSelectRatingCategory);
  }

  void onFetchMovie(FetchMovie event, Emitter<FetchMovieState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await fetchData(emit);
  }

  void onSelectRatingCategory(
    SelectRatingCategory event,
    Emitter<FetchMovieState> emit,
  ) async {
    emit(FetchMovieState.initial());
    emit(state.copyWith(status: Status.loading, category: event.category));
    await fetchData(emit);
  }

  Future<void> fetchData(Emitter<FetchMovieState> emit) async {
    final dataState = await _getMovieListUseCase(
      params: GetMovieListUseCaseParams(
        page: state.pageNumber + 1,
        ratingCategory: state.category,
      ),
    );

    // show loading
    await Future.delayed(const Duration(milliseconds: 1000));

    switch (dataState) {
      case DataSuccess _:
        // pagination
        final movies = [state.movies, dataState.data!].expand((x) => x).toList();
        emit(
          state.copyWith(
            movies: movies,
            status: Status.success,
            pageNumber: state.pageNumber + 1,
            isLastPage: dataState.data!.length != numberOfMoviesPerRequest,
          ),
        );
      case DataFailed _:
        emit(state.copyWith(error: dataState.error?.message, status: Status.failure));
    }
  }
}
