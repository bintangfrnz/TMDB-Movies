part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent {}

class GetMovieDetail extends MovieDetailEvent {
  final String id;
  GetMovieDetail({required this.id});
}

class MarkWatchLater extends MovieDetailEvent {
  final MovieDetailEntity movie;
  MarkWatchLater({required this.movie});
}
