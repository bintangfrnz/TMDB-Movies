import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/config/index.dart';
import 'package:tmdb_movies/core/enums/index.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/core/states/ui_state.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';

import '../../blocs/saved/saved_movie_bloc.dart';
import '../../widgets/index.dart';

class SavedMoviePage extends StatefulWidget {
  const SavedMoviePage({super.key});

  @override
  State<SavedMoviePage> createState() => _SavedMoviePageState();
}

class _SavedMoviePageState extends State<SavedMoviePage> {
  @override
  void initState() {
    _onGetSavedMovies(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: BlocBuilder<SavedMovieBloc, SavedMovieState>(
          builder: (context, state) => template(context, state),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Saved Restaurant',
        style: TextStyle(color: context.theme.scaffoldBackgroundColor),
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget template(BuildContext context, SavedMovieState state) {
    return switch (state.status) {
      Status.loading => uiLoading(),
      Status.success => (state.movies.isEmpty)
          ? uiTemplate(context, message: 'No Movies Saved')
          : _restaurantSection(state),
      _ => const SizedBox(),
    };
  }

  ListView _restaurantSection(SavedMovieState state) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: state.movies.length,
      separatorBuilder: (context, index) => MyDimens.dp8.height,
      itemBuilder: (context, index) {
        final movie = state.movies[index];
        return MovieCard(
          onTap: () => _navigateToDetail(context, movie.id),
          movie: movie,
          trailing: GestureDetector(
            onTap: () => _removeBookmark(context, movie),
            child: Icon(
              Icons.bookmark_added_rounded,
              color: context.theme.colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }

  void _navigateToDetail(BuildContext context, String? id) {
    MyNav.pushNamed(
      MyRoutes.movieDetailRoute,
      arguments: id,
      action: () => _onGetSavedMovies(context),
    );
  }

  void _onGetSavedMovies(BuildContext context) {
    context.read<SavedMovieBloc>().add(GetSavedMovies());
  }

  void _removeBookmark(BuildContext context, MovieEntity movie) {
    context.read<SavedMovieBloc>().add(RemoveMovie(movie: movie));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text('${movie.title} removed from bookmark'),
      ),
    );
  }
}
