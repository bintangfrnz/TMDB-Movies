import 'package:equatable/equatable.dart';

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

  MovieEntity toMovie() => MovieEntity(
        id: id,
        title: title,
        rating: rating,
        posterPath: posterPath,
        releaseDate: releaseDate,
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
