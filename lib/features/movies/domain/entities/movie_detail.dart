import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final String id;
  final String title;
  final String overview;
  final double rating;
  final String backdropPath;
  final String releaseDate;
  final List<String> genres;

  const MovieDetailEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.rating,
    required this.backdropPath,
    required this.releaseDate,
    required this.genres,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        rating,
        backdropPath,
        releaseDate,
        genres,
      ];
}
