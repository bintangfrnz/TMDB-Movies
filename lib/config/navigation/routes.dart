import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tmdb_movies/features/movies/presentation/pages/main/main.dart';

class MyRoutes {
  static Route<dynamic> _materialRoute({required Widget view}) =>
      MaterialPageRoute(builder: (_) => view);

  static Route onGenerateRoutes(RouteSettings settings) {
    log('navigate to ${settings.name}', name: 'ROUTE');
    return switch (settings.name) {
      homeRoute => _materialRoute(view: const MainPage()),
      _ => _materialRoute(view: const Placeholder())
    };
  }

  static const homeRoute = '/home';
}
