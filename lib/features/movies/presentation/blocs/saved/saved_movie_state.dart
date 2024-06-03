part of 'saved_movie_bloc.dart';

class SavedMovieState extends Equatable {
  // core
  final List<MovieEntity> movies;
  final Status status;

  const SavedMovieState({
    this.movies = const <MovieEntity>[],
    this.status = Status.initial,
  });

  factory SavedMovieState.initial() => const SavedMovieState();

  SavedMovieState copyWith({List<MovieEntity>? movies, Status? status}) {
    return SavedMovieState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [movies, status];
}
