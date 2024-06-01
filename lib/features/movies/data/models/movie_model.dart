import 'package:floor/floor.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';

@Entity(tableName: 'movies', primaryKeys: ['id'])
class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.rating,
    required super.posterPath,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['original_title'],
        rating: json['vote_average'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
      );

  factory MovieModel.fromEntity(MovieEntity entity) => MovieModel(
        id: entity.id,
        title: entity.title,
        rating: entity.rating,
        posterPath: entity.posterPath,
        releaseDate: entity.releaseDate,
      );
}
