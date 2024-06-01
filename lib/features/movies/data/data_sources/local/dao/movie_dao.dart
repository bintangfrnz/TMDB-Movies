import 'package:floor/floor.dart';

import '../../../models/movie_model.dart';

@dao
abstract class MovieDao {
  @insert
  Future<void> insertMovie(MovieModel movie);

  @delete
  Future<void> deleteMovie(MovieModel movie);

  @Query('SELECT * FROM movies')
  Future<List<MovieModel>> getMovies();

  @Query('SELECT * FROM movies WHERE id = :id')
  Future<MovieModel?> findMovieById(String id);
}
