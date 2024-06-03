import 'package:floor/floor.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';

@Entity(tableName: 'movies', primaryKeys: ['id'])
class MovieModel extends MovieEntity {
  const MovieModel({
    super.id,
    super.title,
    super.rating,
    super.posterPath,
    super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'].toString(),
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
