import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/index.dart';
import 'features/movies/presentation/blocs/index.dart';
import 'features/splash/splash.dart';

void main() async {
  // Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BnbBloc>(create: (_) => sl()),
        BlocProvider<FetchMovieBloc>(create: (_) => sl()..add(FetchMovie())),
        BlocProvider<MovieDetailBloc>(create: (_) => sl()),
        BlocProvider<SearchMovieBloc>(create: (_) => sl()),
        BlocProvider<SavedMovieBloc>(create: (_) => sl()..add(GetSavedMovies())),
      ],
      child: MaterialApp(
        title: 'TMDB Movies',
        debugShowCheckedModeBanner: false,
        theme: MyLightTheme.theme,
        navigatorKey: navigatorKey,
        onGenerateRoute: MyRoutes.onGenerateRoutes,
        home: const SplashPage(),
      ),
    );
  }
}
