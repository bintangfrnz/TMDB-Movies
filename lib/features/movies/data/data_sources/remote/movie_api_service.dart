import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/movie_detail_model.dart';
import '../../models/response/get_movie_list_response.dart';

part 'movie_api_service.g.dart';

@RestApi()
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET('/discover/movie')
  Future<HttpResponse<GetMovieListResponse>> getMovieList({
    @Query('page') int page = 1,
    @Query('vote_average.gte') num? ratingGte,
    @Query('vote_average.lte') num? ratingLte,
    @Query('include_adult') bool includeAdult = false,
    @Query('include_video') bool includeVideo = false,
    @Query('language') String language = 'en-US',
    @Query('sort_by') String sortBy = 'popularity.desc',
    @Query('with_genres') String? genres,
  });

  @GET('/movie/{movie_id}')
  Future<HttpResponse<MovieDetailModel>> getMovieDetail({
    @Path("movie_id") required int movieId,
  });

  @GET('/search/movie')
  Future<HttpResponse<GetMovieListResponse>> searchMovie({
    @Query('query') String query = '',
    @Query('page') int page = 1,
    @Query('include_adult') bool includeAdult = false,
    @Query('language') String language = 'en-US',
  });
}
