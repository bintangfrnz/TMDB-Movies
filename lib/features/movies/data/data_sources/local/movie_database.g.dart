// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $MovieDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $MovieDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $MovieDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<MovieDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorMovieDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MovieDatabaseBuilderContract databaseBuilder(String name) =>
      _$MovieDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $MovieDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$MovieDatabaseBuilder(null);
}

class _$MovieDatabaseBuilder implements $MovieDatabaseBuilderContract {
  _$MovieDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $MovieDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $MovieDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<MovieDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MovieDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MovieDatabase extends MovieDatabase {
  _$MovieDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movies` (`id` TEXT, `title` TEXT, `rating` REAL, `posterPath` TEXT, `releaseDate` TEXT, `overview` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieModelInsertionAdapter = InsertionAdapter(
            database,
            'movies',
            (MovieModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'rating': item.rating,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'overview': item.overview
                }),
        _movieModelDeletionAdapter = DeletionAdapter(
            database,
            'movies',
            ['id'],
            (MovieModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'rating': item.rating,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'overview': item.overview
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieModel> _movieModelInsertionAdapter;

  final DeletionAdapter<MovieModel> _movieModelDeletionAdapter;

  @override
  Future<List<MovieModel>> getMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movies',
        mapper: (Map<String, Object?> row) => MovieModel(
            id: row['id'] as String?,
            title: row['title'] as String?,
            rating: row['rating'] as double?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            overview: row['overview'] as String?));
  }

  @override
  Future<MovieModel?> findMovieById(String id) async {
    return _queryAdapter.query('SELECT * FROM movies WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieModel(
            id: row['id'] as String?,
            title: row['title'] as String?,
            rating: row['rating'] as double?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            overview: row['overview'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertMovie(MovieModel movie) async {
    await _movieModelInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(MovieModel movie) async {
    await _movieModelDeletionAdapter.delete(movie);
  }
}
