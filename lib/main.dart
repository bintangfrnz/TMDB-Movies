import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/index.dart';
import 'core/helpers/bloc_observer.dart';
import 'features/movies/presentation/blocs/index.dart';
import 'features/splash/splash.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BnbBloc()),
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
