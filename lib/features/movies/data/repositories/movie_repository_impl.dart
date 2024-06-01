import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tmdb_movies/core/enums/rating_category.dart';
import 'package:tmdb_movies/core/states/data_state.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie_detail.dart';
import 'package:tmdb_movies/features/movies/domain/repositories/movie_repository.dart';

import '../data_sources/local/movie_database.dart';
import '../data_sources/remote/movie_api_service.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService _apiService;
  final MovieDatabase _database;

  MovieRepositoryImpl(this._apiService, this._database);

  // region api methods
  @override
  Future<DataState<List<MovieEntity>>> getMovieList({
    required int page,
    required RatingCategory ratingCategory,
  }) async {
    try {
      final (ratingGte, ratingLte) = switch (ratingCategory) {
        RatingCategory.all => (null, null),
        RatingCategory.bad => (0, 3),
        RatingCategory.good => (3.1, 6),
        RatingCategory.great => (6.1, 8),
        RatingCategory.recommended => (8.1, 10),
      };

      final httpResponse = await _apiService.getMovieList(
        page: page,
        ratingGte: ratingGte,
        ratingLte: ratingLte,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.results);
      }
      return _errorStatusCode(httpResponse.response);
    } on DioException catch (e) {
      return _exception(e);
    }
  }

  @override
  Future<DataState<MovieDetailEntity>> getMovieDetail(String movieId) async {
    try {
      final httpResponse = await _apiService.getMovieDetail(movieId: movieId);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }
      return _errorStatusCode(httpResponse.response);
    } on DioException catch (e) {
      return _exception(e);
    }
  }

  @override
  Future<DataState<List<MovieEntity>>> searchMovie({
    required String query,
    required int page,
  }) async {
    try {
      final httpResponse = await _apiService.searchMovie(query: query, page: page);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.results);
      }
      return _errorStatusCode(httpResponse.response);
    } on DioException catch (e) {
      return _exception(e);
    }
  }
  // endregion api methods

  // region database methods
  @override
  Future<List<MovieEntity>> getSavedMovies() => _database.movieDao.getMovies();

  @override
  Future<bool> isMovieSaved(String id) async =>
      await _database.movieDao.findMovieById(id) != null;

  @override
  Future<void> saveMovie(MovieEntity movie) =>
      _database.movieDao.insertMovie(MovieModel.fromEntity(movie));

  @override
  Future<void> removeMovie(MovieEntity movie) =>
      _database.movieDao.deleteMovie(MovieModel.fromEntity(movie));
  // endregion database methods

  // region error
  DataState<T> _exception<T>(DioException error) => switch (error.type) {
        DioExceptionType.connectionError => DataFailed(
            DioException(
              message: 'No Internet Connection',
              requestOptions: RequestOptions(),
            ),
          ),
        _ => DataFailed(error)
      };

  DataState<T> _errorStatusCode<T>(Response response) => DataFailed(
        DioException(
          error: response.statusCode,
          response: response,
          requestOptions: response.requestOptions,
        ),
      );
  // endregion error
}
