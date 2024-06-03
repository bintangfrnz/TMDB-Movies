import 'package:equatable/equatable.dart';
import 'package:tmdb_movies/core/extensions/index.dart';

import 'movie.dart';

class MovieDetailEntity extends Equatable {
  final String? id;
  final String? title;
  final String? overview;
  final double? rating;
  final String? backdropPath;
  final String? posterPath;
  final String? releaseDate;
  final List<String>? genres;

  const MovieDetailEntity({
    this.id,
    this.title,
    this.overview,
    this.rating,
    this.backdropPath,
    this.posterPath,
    this.releaseDate,
    this.genres,
  });

  String getRating() => (rating?.toStringAsFixed(1)).or('-');

  MovieEntity toMovie() => MovieEntity(
        id: id,
        title: title,
        rating: rating,
        posterPath: posterPath,
        releaseDate: releaseDate,
        overview: overview,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        rating,
        backdropPath,
        posterPath,
        releaseDate,
        genres,
      ];
}
