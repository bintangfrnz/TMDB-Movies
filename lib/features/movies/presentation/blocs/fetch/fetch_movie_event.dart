part of 'fetch_movie_bloc.dart';

sealed class FetchMovieEvent {}

class FetchMovie extends FetchMovieEvent {}

class SelectRatingCategory extends FetchMovieEvent {
  final RatingCategory category;
  SelectRatingCategory({required this.category});
}
