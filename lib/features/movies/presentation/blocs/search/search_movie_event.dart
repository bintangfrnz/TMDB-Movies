part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent {}

final class SearchMovie extends SearchMovieEvent {
  final String query;
  SearchMovie({required this.query});
}
