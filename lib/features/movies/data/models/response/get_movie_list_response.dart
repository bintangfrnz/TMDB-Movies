import 'package:tmdb_movies/features/movies/data/models/movie_model.dart';

class GetMovieListResponse {
  final int page;
  final List<MovieModel> results;

  const GetMovieListResponse({required this.page, required this.results});

  factory GetMovieListResponse.fromJson(Map<String, dynamic> json) =>
      GetMovieListResponse(
        page: json['page'],
        results: List<MovieModel>.from(
          json['results'].map((x) => MovieModel.fromJson(x)),
        ),
      );
}
