part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetailEntity? movie;
  final bool watchLater;
  final Status status;
  final String? error;

  const MovieDetailState({
    this.movie,
    this.watchLater = false,
    this.status = Status.initial,
    this.error,
  });

  factory MovieDetailState.initial() => const MovieDetailState();

  MovieDetailState copyWith({
    MovieDetailEntity? movie,
    bool? watchLater,
    Status? status,
    String? error,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      watchLater: watchLater ?? this.watchLater,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [movie, watchLater, status, error];
}
