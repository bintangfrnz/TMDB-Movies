import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/core/constants/constants.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/features/movies/presentation/blocs/index.dart';

import 'play_button.dart';
import 'rating_box.dart';
import 'watch_later.dart';

class MyAppSpace extends StatelessWidget {
  const MyAppSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          final title = state.movie?.title;
          return LayoutBuilder(
            builder: (context, constraints) {
              return (constraints.maxHeight <= 72)
                  ? Text(
                      title.or('-'),
                      style: context.theme.textTheme.titleSmall
                          ?.copyWith(color: context.theme.scaffoldBackgroundColor),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const RatingBox(),
                        const PlayButton(),
                        WatchLater(
                          onTapWatchLater: () {
                            final title = (state.movie?.title).or('-');
                            final message = (state.watchLater)
                                ? '$title removed to bookmark'
                                : '$title added from bookmark';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(message),
                              ),
                            );
                            context
                                .read<MovieDetailBloc>()
                                .add(MarkWatchLater(movie: state.movie!));
                          },
                        ),
                      ],
                    );
            },
          );
        },
      ),
      background: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              final backdropPath = (state.movie?.backdropPath).or('/invalid.jpg');
              return FadeInImage.assetNetwork(
                height: MyDimens.height(context),
                width: MyDimens.width(context),
                fit: BoxFit.cover,
                image: '$imageLargeUrl$backdropPath}',
                imageErrorBuilder: (x, y, z) => Image.asset(MyAssets.placeholder),
                placeholder: MyAssets.placeholder,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.theme.colorScheme.inverseSurface.withOpacity(0.9),
                  Colors.transparent,
                  context.theme.colorScheme.inverseSurface.withOpacity(0.9),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ],
      ),
      stretchModes: const [StretchMode.zoomBackground],
    );
  }
}
