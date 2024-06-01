import 'package:tmdb_movies/features/movies/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetailEntity {
  const MovieDetailModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.rating,
    required super.backdropPath,
    required super.releaseDate,
    required super.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => MovieDetailModel(
        id: json['id'],
        title: json['original_title'],
        overview: json['overview'],
        rating: json['vote_average'],
        backdropPath: json['backdrop_path'],
        releaseDate: json['release_date'],
        genres: List<String>.from(json['id'].map((genre) => genre['name'])),
      );
}
