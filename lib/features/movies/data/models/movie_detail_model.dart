import 'package:tmdb_movies/features/movies/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetailEntity {
  const MovieDetailModel({
    super.id,
    super.title,
    super.overview,
    super.rating,
    super.backdropPath,
    super.posterPath,
    super.releaseDate,
    super.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => MovieDetailModel(
        id: json['id'].toString(),
        title: json['original_title'],
        overview: json['overview'],
        rating: json['vote_average'],
        backdropPath: json['backdrop_path'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        genres: List<GenresModel>.from(
          json['genres'].map((x) => GenresModel.fromJson(x)),
        ),
      );
}

class GenresModel extends GenresEntity {
  const GenresModel({super.id, super.name});

  factory GenresModel.fromJson(Map<String, dynamic> json) => GenresModel(
        id: json['id'],
        name: json['name'],
      );
}
