import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/features/movies/presentation/pages/home/home.dart';
import 'package:tmdb_movies/features/movies/presentation/pages/settings/settings.dart';

import '../../blocs/bnb/bnb_bloc.dart';
import '../saved/saved_movie.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const SavedMoviePage(),
      const SettingsPage(),
    ];

    return BlocBuilder<BnbBloc, int>(
      builder: (context, index) {
        return Scaffold(
          body: pages[index],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            currentIndex: index,
            onTap: (value) => context.read<BnbBloc>().add(OnTapBnb(value)),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_outline_rounded),
                activeIcon: Icon(Icons.bookmark_rounded),
                label: 'Watch Later',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
