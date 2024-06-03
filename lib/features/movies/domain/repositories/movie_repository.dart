import 'package:tmdb_movies/core/enums/rating_category.dart';
import 'package:tmdb_movies/core/states/data_state.dart';

import '../entities/movie.dart';
import '../entities/movie_detail.dart';

abstract class MovieRepository {
  // api methods
  Future<DataState<List<MovieEntity>>> getMovieList({
    required int page,
    required RatingCategory ratingCategory,
  });
  Future<DataState<MovieDetailEntity>> getMovieDetail(String movieId);
  Future<DataState<List<MovieEntity>>> searchMovie({
    required String query,
    required int page,
  });

  // database methods
  Future<List<MovieEntity>> getSavedMovies();
  Future<bool> isMovieSaved(String id);
  Future<void> saveMovie(MovieEntity movie);
  Future<void> removeMovie(MovieEntity movie);
}
