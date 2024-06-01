import 'package:tmdb_movies/core/base/base_use_case.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class RemoveMovieUseCase implements BaseUseCase<void, MovieEntity> {
  final MovieRepository _repository;
  RemoveMovieUseCase(this._repository);

  @override
  Future<void> call({required MovieEntity params}) {
    return _repository.removeMovie(params);
  }
}
