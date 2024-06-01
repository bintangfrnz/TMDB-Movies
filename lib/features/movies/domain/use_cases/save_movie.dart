import 'package:tmdb_movies/core/base/base_use_case.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SaveMovieUseCase implements BaseUseCase<void, MovieEntity> {
  final MovieRepository _repository;
  SaveMovieUseCase(this._repository);

  @override
  Future<void> call({required MovieEntity params}) {
    return _repository.saveMovie(params);
  }
}
