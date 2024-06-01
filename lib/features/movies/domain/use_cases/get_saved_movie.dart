import 'package:tmdb_movies/core/base/base_use_case.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetSavedMovieUseCase implements BaseUseCase<List<MovieEntity>, void> {
  final MovieRepository _repository;
  GetSavedMovieUseCase(this._repository);

  @override
  Future<List<MovieEntity>> call({void params}) {
    return _repository.getSavedMovies();
  }
}
