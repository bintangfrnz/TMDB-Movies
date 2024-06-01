import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/movie_model.dart';
import 'dao/movie_dao.dart';

part 'movie_database.g.dart';

@Database(version: 1, entities: [MovieModel])
abstract class MovieDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
