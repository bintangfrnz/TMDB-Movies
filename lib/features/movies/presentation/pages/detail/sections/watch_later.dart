import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/features/movies/presentation/blocs/detail/movie_detail_bloc.dart';

class WatchLater extends StatelessWidget {
  final Function() onTapWatchLater;
  const WatchLater({super.key, required this.onTapWatchLater});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapWatchLater,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MyDimens.dp12,
          vertical: MyDimens.dp8,
        ),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(MyDimens.dp4),
        ),
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            return (state.watchLater)
                ? _content(context, Icons.bookmark_added_rounded, 'Saved')
                : _content(context, Icons.bookmark_add_outlined, 'Save');
          },
        ),
      ),
    );
  }

  Wrap _content(BuildContext context, IconData icon, String text) {
    return Wrap(
      spacing: MyDimens.dp4,
      alignment: WrapAlignment.center,
      children: [
        Icon(
          icon,
          size: MyDimens.dp16,
          color: context.theme.scaffoldBackgroundColor,
        ),
        Text(
          text,
          style: context.theme.textTheme.bodySmall
              ?.copyWith(color: context.theme.scaffoldBackgroundColor),
        ),
      ],
    );
  }
}
