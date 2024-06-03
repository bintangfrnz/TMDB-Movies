import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/core/enums/status.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/states/data_state.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie_detail.dart';
import 'package:tmdb_movies/features/movies/domain/use_cases/index.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUseCase _getMovieDetailUseCase;
  final IsMovieSavedUseCase _isMovieSavedUseCase;
  final SaveMovieUseCase _saveMovieUseCase;
  final RemoveMovieUseCase _removeMovieUseCase;

  MovieDetailBloc(
    this._getMovieDetailUseCase,
    this._isMovieSavedUseCase,
    this._saveMovieUseCase,
    this._removeMovieUseCase,
  ) : super(MovieDetailState.initial()) {
    on<GetMovieDetail>(onGetMovieDetail);
    on<MarkWatchLater>(onMarkWatchLater);
  }

  void onGetMovieDetail(
    GetMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final dataState = await _getMovieDetailUseCase(params: event.id);
    final watchLater = await _isMovieSavedUseCase(params: event.id);

    // show loading longer
    await Future.delayed(const Duration(milliseconds: 200));

    switch (dataState) {
      case DataSuccess _:
        emit(state.copyWith(
          movie: dataState.data!,
          watchLater: watchLater,
          status: Status.success,
        ));
      case DataFailed _:
        emit(state.copyWith(error: dataState.error?.message, status: Status.failure));
    }
  }

  void onMarkWatchLater(MarkWatchLater event, Emitter<MovieDetailState> emit) async {
    final watchLater = await _isMovieSavedUseCase(params: event.movie.id.or());
    (watchLater)
        ? await _removeMovieUseCase(params: event.movie.toMovie())
        : await _saveMovieUseCase(params: event.movie.toMovie());
    emit(state.copyWith(watchLater: !watchLater));
  }
}
