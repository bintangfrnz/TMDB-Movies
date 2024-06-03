part of 'fetch_movie_bloc.dart';

class FetchMovieState extends Equatable {
  // core
  final List<MovieEntity> movies;
  final RatingCategory category;
  final Status status;
  final String? error;

  // additional
  final int pageNumber;
  final bool isLastPage;

  const FetchMovieState({
    this.movies = const <MovieEntity>[],
    this.category = RatingCategory.all,
    this.status = Status.initial,
    this.error,
    this.pageNumber = 0,
    this.isLastPage = false,
  });

  factory FetchMovieState.initial() => const FetchMovieState();
  factory FetchMovieState.refresh() => const FetchMovieState(status: Status.loading);

  FetchMovieState copyWith({
    List<MovieEntity>? movies,
    RatingCategory? category,
    Status? status,
    String? error,
    int? pageNumber,
    bool? isLastPage,
  }) {
    return FetchMovieState(
      movies: movies ?? this.movies,
      category: category ?? this.category,
      status: status ?? this.status,
      error: error,
      pageNumber: pageNumber ?? this.pageNumber,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [movies, category, status, error, pageNumber, isLastPage];
}
