part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetailEntity? movie;
  final bool watchLater;
  final Status status;
  final String? error;
  final List<MovieEntity> similarMovies;

  const MovieDetailState({
    this.movie,
    this.watchLater = false,
    this.status = Status.initial,
    this.error,
    this.similarMovies = const [],
  });

  factory MovieDetailState.initial() => const MovieDetailState();

  MovieDetailState copyWith({
    MovieDetailEntity? movie,
    bool? watchLater,
    Status? status,
    String? error,
    List<MovieEntity>? similarMovies,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      watchLater: watchLater ?? this.watchLater,
      status: status ?? this.status,
      error: error,
      similarMovies: similarMovies ?? this.similarMovies,
    );
  }

  @override
  List<Object?> get props => [movie, watchLater, status, error, similarMovies];
}
