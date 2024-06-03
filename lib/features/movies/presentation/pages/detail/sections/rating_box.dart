import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/features/movies/presentation/blocs/detail/movie_detail_bloc.dart';

class RatingBox extends StatelessWidget {
  const RatingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MyDimens.dp12,
        vertical: MyDimens.dp8,
      ),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(MyDimens.dp4),
      ),
      child: Wrap(
        spacing: MyDimens.dp4,
        alignment: WrapAlignment.center,
        children: [
          Icon(
            Icons.star,
            size: MyDimens.dp16,
            color: context.theme.colorScheme.tertiary,
          ),
          BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              return Text(
                (state.movie?.getRating()).or('-'),
                style: context.theme.textTheme.bodySmall
                    ?.copyWith(color: context.theme.scaffoldBackgroundColor),
              );
            },
          ),
        ],
      ),
    );
  }
}
