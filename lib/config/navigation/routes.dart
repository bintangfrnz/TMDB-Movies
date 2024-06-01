import 'dart:developer';

import 'package:flutter/material.dart';

class MyRoutes {
  static Route<dynamic> _materialRoute({required Widget view}) =>
      MaterialPageRoute(builder: (_) => view);

  static Route onGenerateRoutes(RouteSettings settings) {
    log('navigate to ${settings.name}', name: 'ROUTE');
    return switch (settings.name) { _ => _materialRoute(view: const Placeholder()) };
  }
}
