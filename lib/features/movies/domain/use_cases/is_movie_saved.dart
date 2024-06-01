import 'package:tmdb_movies/core/base/base_use_case.dart';

import '../repositories/movie_repository.dart';

class IsMovieSavedUseCase implements BaseUseCase<bool, String> {
  final MovieRepository _repository;
  IsMovieSavedUseCase(this._repository);

  @override
  Future<bool> call({required String params}) {
    return _repository.isMovieSaved(params);
  }
}
