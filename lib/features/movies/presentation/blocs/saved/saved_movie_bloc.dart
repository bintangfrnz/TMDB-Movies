import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/core/enums/status.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';
import 'package:tmdb_movies/features/movies/domain/use_cases/get_saved_movie.dart';
import 'package:tmdb_movies/features/movies/domain/use_cases/remove_movie.dart';

part 'saved_movie_event.dart';
part 'saved_movie_state.dart';

class SavedMovieBloc extends Bloc<SavedMovieEvent, SavedMovieState> {
  final GetSavedMovieUseCase _getSavedMovieUseCase;
  final RemoveMovieUseCase _removeMovieUseCase;

  SavedMovieBloc(
    this._getSavedMovieUseCase,
    this._removeMovieUseCase,
  ) : super(SavedMovieState.initial()) {
    on<GetSavedMovies>(onGetSavedMovies);
    on<RemoveMovie>(onRemoveMovie);
  }

  Future<void> getSavedMovies(Emitter<SavedMovieState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final movies = await _getSavedMovieUseCase();
    emit(state.copyWith(movies: movies, status: Status.success));
  }

  void onGetSavedMovies(GetSavedMovies event, Emitter<SavedMovieState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await getSavedMovies(emit);
  }

  void onRemoveMovie(
    RemoveMovie event,
    Emitter<SavedMovieState> emit,
  ) async {
    await _removeMovieUseCase(params: event.movie);
    await getSavedMovies(emit);
  }
}
