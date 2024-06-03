import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb_movies/core/extensions/sized_box_ext.dart';
import 'package:tmdb_movies/core/resources/dimens.dart';

import 'label_input.dart';

class RegularTextInput extends StatelessWidget {
  const RegularTextInput({
    super.key,
    required this.hintText,
    this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.label,
    this.required = false,
    this.onChanged,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final IconData? prefixIcon;
  final String? label;
  final bool required;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          LabelInput(label: label, required: required),
          MyDimens.dp8.height,
        ],
        TextFormField(
          controller: controller,
          enabled: enabled,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          onChanged: onChanged,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            hintText: hintText,
            suffixIcon: suffix,
          ),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
      ],
    );
  }
}
