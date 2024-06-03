import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tmdb_movies/features/movies/presentation/pages/index.dart';

class MyRoutes {
  static Route<dynamic> _materialRoute({required Widget view}) =>
      MaterialPageRoute(builder: (_) => view);

  static Route onGenerateRoutes(RouteSettings settings) {
    log('navigate to ${settings.name}', name: 'ROUTE');
    final argument = settings.arguments;
    return switch (settings.name) {
      homeRoute => _materialRoute(view: const MainPage()),
      movieDetailRoute => _materialRoute(view: MovieDetailPage(id: argument as String)),
      searchMovieRoute => _materialRoute(view: const SearchPage()),
      _ => _materialRoute(view: const Placeholder())
    };
  }

  static const homeRoute = '/movies';
  static const movieDetailRoute = '/movies/id';
  static const searchMovieRoute = '/search';
}
