import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/index.dart';
import 'core/helpers/bloc_observer.dart';
import 'features/splash/splash.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB Movies',
      debugShowCheckedModeBanner: false,
      theme: LightTheme.theme,
      navigatorKey: navigatorKey,
      onGenerateRoute: MyRoutes.onGenerateRoutes,
      home: const SplashPage(),
    );
  }
}
