import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmdb_movies/config/index.dart';
import 'package:tmdb_movies/core/enums/index.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/core/states/ui_state.dart';

import '../../blocs/detail/movie_detail_bloc.dart';
import '../../widgets/index.dart';
import 'sections/flexible_app_bar.dart';

class MovieDetailPage extends StatefulWidget {
  final String id;

  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    _onGetMovieDetail(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) => template(context, state),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            _buildAppBar(state),
            _buildTitle(),
            _buildGenres(),
            _buildOverview(),
            _buildDownloadButton(context),
            _buildShareButton(context),
            if (state.similarMovies.isNotEmpty) ...[
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MyDimens.dp16,
                  vertical: MyDimens.dp8,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Similar Movies',
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              SliverList.builder(
                itemCount: state.similarMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.similarMovies[index];
                  return MovieCard(
                    onTap: () => _navigateToDetail(movie.id),
                    movie: movie,
                    trailing: Wrap(
                      spacing: MyDimens.dp4,
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: MyDimens.dp16,
                          color: context.theme.colorScheme.secondary,
                        ),
                        Text(
                          movie.getRating(),
                          style: context.theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],
        );
      },
    );
  }

  SliverAppBar _buildAppBar(MovieDetailState state) {
    return SliverAppBar(
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: MyDimens.dp16, top: MyDimens.dp4),
        child: SvgPicture.asset(MyAssets.logoAltShort),
      ),
      pinned: true,
      expandedHeight: 300.0,
      flexibleSpace: const MyAppSpace(),
    );
  }

  SliverPadding _buildTitle() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: MyDimens.dp16,
        vertical: MyDimens.dp8,
      ),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            final title = state.movie?.title;
            return Text(
              title.or('-'),
              style: context.theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildGenres() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MyDimens.dp24,
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            final genres = state.movie?.genres;
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: MyDimens.dp16),
              scrollDirection: Axis.horizontal,
              itemCount: genres?.length ?? 0,
              separatorBuilder: (context, index) => MyDimens.dp8.width,
              itemBuilder: (context, index) {
                final genre = genres?[index].name;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: MyDimens.dp12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(MyDimens.dp8),
                    color: context.theme.primaryColor,
                    border: Border.all(color: context.theme.primaryColor),
                  ),
                  child: Center(
                    child: Text(
                      genre.or('-'),
                      style: context.theme.textTheme.labelSmall?.copyWith(
                        color: context.theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  SliverPadding _buildOverview() {
    return SliverPadding(
      padding: const EdgeInsets.all(MyDimens.dp16),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            final overview = state.movie?.overview;
            return Text(overview.or('No overview'));
          },
        ),
      ),
    );
  }

  SliverPadding _buildDownloadButton(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: MyDimens.dp16),
      sliver: SliverToBoxAdapter(
        child: ElevatedButton.icon(
          onPressed: () => _showNotImplemented(context),
          icon: const Icon(Icons.download_rounded),
          label: const Text('Download'),
        ),
      ),
    );
  }

  SliverPadding _buildShareButton(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: MyDimens.dp16),
      sliver: SliverToBoxAdapter(
        child: ElevatedButton.icon(
          onPressed: () => _showNotImplemented(context),
          icon: const Icon(Icons.share_rounded),
          label: const Text('Share'),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.theme.colorScheme.inverseSurface,
          ),
        ),
      ),
    );
  }

  Widget template(BuildContext context, MovieDetailState state) {
    return switch (state.status) {
      Status.initial => const SizedBox(),
      Status.loading => uiLoading(),
      Status.failure => uiTemplate(
          context,
          template: UITemplate.error,
          message: state.error.or(),
          displayMessage: state.error,
          refreshAction: () {
            context.read<MovieDetailBloc>().add(GetMovieDetail(id: widget.id));
          },
        ),
      Status.success => _content(context),
    };
  }

  dynamic _showNotImplemented(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(duration: Duration(seconds: 1), content: Text('Not Implemented')),
    );
  }

  void _onGetMovieDetail(BuildContext context, String id) {
    context.read<MovieDetailBloc>().add(GetMovieDetail(id: id));
  }

  void _navigateToDetail(String? id) {
    MyNav.pushNamed(MyRoutes.movieDetailRoute, arguments: id);
  }
}
