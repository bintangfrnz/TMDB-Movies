import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb_movies/config/navigation/index.dart';
import 'package:tmdb_movies/core/enums/rating_category.dart';
import 'package:tmdb_movies/core/enums/status.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/core/states/ui_state.dart';
import 'package:tmdb_movies/core/widgets/shimmer/shimmer_list_view.dart';

import '../../blocs/fetch/fetch_movie_bloc.dart';
import '../../widgets/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void fetchNextPage() {
    final nextPageTrigger = _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels == nextPageTrigger) {
      _onFetchMovie(context);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(fetchNextPage);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(fetchNextPage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchMovieBloc, FetchMovieState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(child: _buildBody(context)),
          floatingActionButton: _buildFab(state.movies.isEmpty, state.movies.length),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Movies Bank',
        style: TextStyle(
          color: context.theme.scaffoldBackgroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: MyDimens.dp16),
        child: SvgPicture.asset(MyAssets.logoShort),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded),
          onPressed: _navigateToSearch,
        ),
      ],
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildChipAppBar(context),
        Expanded(
          child: BlocBuilder<FetchMovieBloc, FetchMovieState>(
            builder: (context, state) {
              if (state.movies.isEmpty) {
                return template(context, state);
              }

              return RefreshIndicator(
                onRefresh: () async => _onSelectRatingCategory(context, state.category),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: state.movies.length + (state.isLastPage ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index == state.movies.length && !state.isLastPage) {
                      return (state.status == Status.failure)
                          ? uiTemplate(
                              context,
                              message: 'swipe again to refresh',
                              displayMessage: state.error,
                              includeImage: false,
                            )
                          : uiLoading();
                    }

                    final movie = state.movies[index];
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
              );
            },
          ),
        ),
      ],
    );
  }

  Widget? _buildFab(bool noData, int total) {
    return (noData) ? null : FabSection(total: total);
  }

  Widget _buildChipAppBar(BuildContext context) {
    return Container(
      height: MyDimens.dp36,
      margin: const EdgeInsets.only(top: MyDimens.dp8, bottom: MyDimens.dp4),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: RatingCategory.values.length,
        separatorBuilder: (context, index) => MyDimens.dp8.width,
        itemBuilder: (context, index) {
          final category = RatingCategory.values[index];
          return BlocBuilder<FetchMovieBloc, FetchMovieState>(
            builder: (context, state) {
              return ChoiceChip(
                  backgroundColor: Colors.transparent,
                  label: Text(category.valueName),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  selected: state.category == category,
                  onSelected: (_) => _onSelectRatingCategory(context, category));
            },
          );
        },
      ),
    );
  }

  Widget template(BuildContext context, FetchMovieState state) {
    return switch (state.status) {
      Status.initial => const SizedBox(),
      Status.loading => const ShimmerListView(padding: EdgeInsets.all(MyDimens.dp20)),
      Status.failure => uiTemplate(
          context,
          template: UITemplate.error,
          message: state.error.or(),
          displayMessage: state.error,
          refreshAction: () => _onFetchMovie(context),
        ),
      Status.success => uiTemplate(context),
    };
  }

  void _onFetchMovie(BuildContext context) {
    context.read<FetchMovieBloc>().add(FetchMovie());
  }

  void _onSelectRatingCategory(BuildContext context, RatingCategory category) {
    context.read<FetchMovieBloc>().add(SelectRatingCategory(category: category));
  }

  void _navigateToSearch() {
    MyNav.pushNamed(MyRoutes.searchMovieRoute);
  }

  void _navigateToDetail(String? id) {
    MyNav.pushNamed(MyRoutes.movieDetailRoute, arguments: id);
  }
}
