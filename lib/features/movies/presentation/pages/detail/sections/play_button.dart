import 'package:flutter/material.dart';
import 'package:tmdb_movies/core/extensions/index.dart';
import 'package:tmdb_movies/core/resources/index.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showNotImplemented(context),
      child: Container(
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
              Icons.play_arrow_rounded,
              size: MyDimens.dp16,
              color: context.theme.scaffoldBackgroundColor,
            ),
            Text(
              'Play',
              style: context.theme.textTheme.bodySmall
                  ?.copyWith(color: context.theme.scaffoldBackgroundColor),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _showNotImplemented(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(duration: Duration(seconds: 1), content: Text('Not Implemented')),
    );
  }
}
