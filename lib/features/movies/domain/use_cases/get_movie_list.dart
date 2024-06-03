import 'package:tmdb_movies/core/base/base_use_case.dart';
import 'package:tmdb_movies/core/enums/rating_category.dart';
import 'package:tmdb_movies/core/states/data_state.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetMovieListUseCase
    implements BaseUseCase<DataState<List<MovieEntity>>, GetMovieListUseCaseParams> {
  final MovieRepository _repository;
  GetMovieListUseCase(this._repository);

  @override
  Future<DataState<List<MovieEntity>>> call({
    required GetMovieListUseCaseParams params,
  }) {
    return _repository.getMovieList(
      page: params.page,
      ratingCategory: params.ratingCategory,
      genres: params.genres,
    );
  }
}

class GetMovieListUseCaseParams {
  final int page;
  final RatingCategory ratingCategory;
  final String? genres;

  GetMovieListUseCaseParams({
    required this.page,
    required this.ratingCategory,
    this.genres,
  });
}
