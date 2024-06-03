import 'package:flutter/material.dart';
import 'package:tmdb_movies/core/constants/constants.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/helpers/date_time_helper.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/features/movies/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;
  final Widget? trailing;
  final Function() onTap;

  const MovieCard({super.key, required this.movie, this.trailing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: MyDimens.dp16,
        vertical: MyDimens.dp4,
      ),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(MyDimens.dp4),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: context.theme.primaryColor.withOpacity(.5),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(MyDimens.dp4),
                child: FadeInImage.assetNetwork(
                  image: '$imageSmallUrl${movie.posterPath}',
                  height: MyDimens.dp120,
                  width: MyDimens.dp80,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (x, y, z) => Image.asset(MyAssets.placeholder),
                  placeholder: MyAssets.placeholder,
                ),
              ),
              MyDimens.dp16.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title.or('no title'),
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    MyDimens.dp2.height,
                    Text(
                      movie.overview.or('No overview'),
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    MyDimens.dp8.height,
                    Text(
                      DateTimeHelper.parse(movie.releaseDate.or('')),
                      style: context.theme.textTheme.bodySmall
                          ?.copyWith(color: MyColors.grey),
                    ),
                  ],
                ),
              ),
              MyDimens.dp8.width,
              if (trailing != null) ...[
                trailing!,
                MyDimens.dp20.width,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
