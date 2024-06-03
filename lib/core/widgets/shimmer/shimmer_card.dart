import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb_movies/core/extensions/index.dart';

import '../../resources/index.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.grey.shade300,
      highlightColor: MyColors.grey.shade100,
      child: Container(
        width: MyDimens.width(context),
        height: MyDimens.dp100,
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(MyDimens.dp16),
        ),
      ),
    );
  }
}
