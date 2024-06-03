part of 'search_movie_bloc.dart';

class SearchMovieState extends Equatable {
  // core
  final List<MovieEntity> movies;
  final String query;
  final Status status;
  final String? error;

  // additional
  final int pageNumber;
  final bool isLastPage;

  const SearchMovieState({
    this.movies = const <MovieEntity>[],
    this.query = '',
    this.status = Status.initial,
    this.error,
    this.pageNumber = 0,
    this.isLastPage = false,
  });

  factory SearchMovieState.initial() => const SearchMovieState();

  SearchMovieState copyWith({
    List<MovieEntity>? movies,
    String? query,
    Status? status,
    String? error,
    int? pageNumber,
    bool? isLastPage,
  }) {
    return SearchMovieState(
      movies: movies ?? this.movies,
      query: query ?? this.query,
      status: status ?? this.status,
      error: error,
      pageNumber: pageNumber ?? this.pageNumber,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [movies, query, status, error, pageNumber, isLastPage];
}
