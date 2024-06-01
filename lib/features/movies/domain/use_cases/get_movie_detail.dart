import 'package:tmdb_movies/core/base/base_use_case.dart';
import 'package:tmdb_movies/core/states/data_state.dart';

import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetailUseCase
    implements BaseUseCase<DataState<MovieDetailEntity>, String> {
  final MovieRepository _repository;
  GetMovieDetailUseCase(this._repository);

  @override
  Future<DataState<MovieDetailEntity>> call({required String params}) {
    return _repository.getMovieDetail(params);
  }
}
