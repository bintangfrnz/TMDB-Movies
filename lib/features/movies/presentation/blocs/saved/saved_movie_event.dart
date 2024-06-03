part of 'saved_movie_bloc.dart';

sealed class SavedMovieEvent {}

class GetSavedMovies extends SavedMovieEvent {}

class RemoveMovie extends SavedMovieEvent {
  final MovieEntity movie;
  RemoveMovie({required this.movie});
}
