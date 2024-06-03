import 'package:flutter/material.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';

class FabSection extends StatelessWidget {
  final int total;
  const FabSection({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MyDimens.dp16,
        vertical: MyDimens.dp8,
      ),
      decoration: BoxDecoration(
        color: context.theme.primaryColor,
        borderRadius: BorderRadius.circular(MyDimens.dp8),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: context.theme.primaryColor.withOpacity(.5),
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        'Total: $total',
        style: TextStyle(color: context.theme.scaffoldBackgroundColor),
      ),
    );
  }
}
