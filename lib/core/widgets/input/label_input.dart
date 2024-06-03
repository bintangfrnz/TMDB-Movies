import 'package:flutter/material.dart';
import 'package:tmdb_movies/core/extensions/theme_ext.dart';
import 'package:tmdb_movies/core/resources/index.dart';

class LabelInput extends StatelessWidget {
  const LabelInput({
    super.key,
    required this.label,
    this.required = false,
  });

  final String? label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: context.theme.textTheme.labelMedium,
        children: [
          if (required)
            TextSpan(
              text: ' *',
              style: TextStyle(
                fontSize: MyDimens.dp10,
                color: context.theme.colorScheme.error,
              ),
            ),
        ],
      ),
    );
  }
}
