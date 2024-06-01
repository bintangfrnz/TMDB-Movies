import 'package:tmdb_movies/core/base/base_use_case.dart';
import 'package:tmdb_movies/core/states/data_state.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMovieUseCase
    implements BaseUseCase<DataState<List<MovieEntity>>, SearchMovieUseCaseParams> {
  final MovieRepository _repository;
  SearchMovieUseCase(this._repository);

  @override
  Future<DataState<List<MovieEntity>>> call({
    required SearchMovieUseCaseParams params,
  }) {
    return _repository.searchMovie(query: params.query, page: params.page);
  }
}

class SearchMovieUseCaseParams {
  final String query;
  final int page;

  SearchMovieUseCaseParams({required this.query, required this.page});
}
