import 'package:flutter/material.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/widgets/shimmer/shimmer_card.dart';

import '../../resources/index.dart';

class ShimmerListView extends StatelessWidget {
  final EdgeInsets padding;
  const ShimmerListView({super.key, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (context, index) => MyDimens.dp20.height,
        itemBuilder: (context, index) => const ShimmerCard(),
      ),
    );
  }
}
