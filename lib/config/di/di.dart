import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb_movies/core/network/dio.dart';
import 'package:tmdb_movies/core/network/interceptor/authorization_interceptor.dart';
import 'package:tmdb_movies/features/movies/data/data_sources/index.dart';
import 'package:tmdb_movies/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:tmdb_movies/features/movies/domain/repositories/movie_repository.dart';
import 'package:tmdb_movies/features/movies/domain/use_cases/index.dart';
import 'package:tmdb_movies/features/movies/presentation/blocs/index.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // region database
  final pref = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(pref);

  final db = await $FloorMovieDatabase.databaseBuilder('movie_database.db').build();
  sl.registerSingleton<MovieDatabase>(db);
  // endregion database

  // region network
  sl.registerSingleton<AuthorizationInterceptor>(AuthorizationInterceptor(sl()));

  final myDio = MyDio(sl<AuthorizationInterceptor>());
  sl.registerSingleton<Dio>(myDio.dio);
  sl.registerSingleton<MovieApiService>(MovieApiService(sl()));
  // endregion network

  // region repository
  sl.registerSingleton<MovieRepository>(MovieRepositoryImpl(sl(), sl()));
  // endregion repository

  // region use cases
  sl.registerSingleton<GetMovieListUseCase>(GetMovieListUseCase(sl()));
  sl.registerSingleton<GetMovieDetailUseCase>(GetMovieDetailUseCase(sl()));
  sl.registerSingleton<SearchMovieUseCase>(SearchMovieUseCase(sl()));

  sl.registerSingleton<GetSavedMovieUseCase>(GetSavedMovieUseCase(sl()));
  sl.registerSingleton<IsMovieSavedUseCase>(IsMovieSavedUseCase(sl()));
  sl.registerSingleton<RemoveMovieUseCase>(RemoveMovieUseCase(sl()));
  sl.registerSingleton<SaveMovieUseCase>(SaveMovieUseCase(sl()));
  // endregion use cases

  // region blocs
  sl.registerSingleton<BnbBloc>(BnbBloc());
  sl.registerSingleton<MovieDetailBloc>(MovieDetailBloc(sl(), sl(), sl(), sl()));
  sl.registerSingleton<FetchMovieBloc>(FetchMovieBloc(sl()));
  sl.registerSingleton<SavedMovieBloc>(SavedMovieBloc(sl(), sl()));
  sl.registerSingleton<SearchMovieBloc>(SearchMovieBloc(sl()));
  // endregion blocs
}
