import 'package:equatable/equatable.dart';
import 'package:tmdb_movies/core/extensions/index.dart';

class MovieEntity extends Equatable {
  final String? id;
  final String? title;
  final double? rating;
  final String? posterPath;
  final String? releaseDate;
  final String? overview;

  const MovieEntity({
    this.id,
    this.title,
    this.rating,
    this.posterPath,
    this.releaseDate,
    this.overview,
  });

  String getRating() => (rating?.toStringAsFixed(1)).or('-');

  @override
  List<Object?> get props => [id, title, rating, posterPath, releaseDate, overview];
}
