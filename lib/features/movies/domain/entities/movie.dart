import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String? id;
  final String? title;
  final double? rating;
  final String? posterPath;
  final String? releaseDate;

  const MovieEntity({
    this.id,
    this.title,
    this.rating,
    this.posterPath,
    this.releaseDate,
  });

  @override
  List<Object?> get props => [id, title, rating, posterPath, releaseDate];
}
