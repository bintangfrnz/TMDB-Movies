import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_movies/config/index.dart';
import 'package:tmdb_movies/core/enums/status.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';
import 'package:tmdb_movies/core/states/ui_state.dart';
import 'package:tmdb_movies/core/widgets/input/search_input.dart';
import 'package:tmdb_movies/core/widgets/shimmer/shimmer_list_view.dart';

import '../../blocs/search/search_movie_bloc.dart';
import '../../widgets/index.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void fetchNextPage() {
    final nextPageTrigger = _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels == nextPageTrigger) {
      _onSearchMovie(context, _controller.text);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(fetchNextPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.removeListener(fetchNextPage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) => _onSearchMovie(context, ''),
      child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: SafeArea(child: _buildBody(context)),
            floatingActionButton: _buildFab(state.movies.isEmpty, state.movies.length),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Search Movie',
        style: TextStyle(color: context.theme.scaffoldBackgroundColor),
      ),
      leading: const IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: MyNav.pop,
      ),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      children: [
        _searchSection(context),
        _loadingIndicator(),
        MyDimens.dp16.height,
        Expanded(
          child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
              if (state.movies.isEmpty) {
                return template(context, state);
              }
              return ListView.builder(
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
                  );
                },
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

  Padding _searchSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MyDimens.dp16,
        MyDimens.dp16,
        MyDimens.dp16,
        MyDimens.dp0,
      ),
      child: SearchTextInput(
        controller: _controller,
        hintText: 'Search by movies name',
        onChanged: (value) => _onSearchMovie(context, value),
      ),
    );
  }

  BlocBuilder<SearchMovieBloc, SearchMovieState> _loadingIndicator() {
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      builder: (context, state) => (state.status == Status.loading)
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: MyDimens.dp20),
              child: LinearProgressIndicator(minHeight: 2),
            )
          : const SizedBox(),
    );
  }

  Widget template(BuildContext context, SearchMovieState state) {
    return switch (state.status) {
      Status.initial => uiTemplate(
          context,
          template: UITemplate.search,
          message: 'Find the movie you want!',
        ),
      Status.loading => const ShimmerListView(padding: EdgeInsets.all(MyDimens.dp20)),
      Status.failure => uiTemplate(
          context,
          template: UITemplate.error,
          message: state.error.or(),
          displayMessage: state.error,
          refreshAction: () => _onSearchMovie(context, _controller.text),
        ),
      Status.success => uiTemplate(context),
    };
  }

  void _onSearchMovie(BuildContext context, String value) {
    context.read<SearchMovieBloc>().add(SearchMovie(query: value));
  }

  void _navigateToDetail(String? id) {
    MyNav.pushNamed(MyRoutes.movieDetailRoute, arguments: id);
  }
}
