import 'package:flutter/material.dart';

import '../../core/resources/index.dart';

class MyLightTheme {
  MyLightTheme._();

  static const fontFamily = 'SF Pro';

  static ColorScheme get colorScheme => ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: MyColors.primary,
        primary: MyColors.primary,
        secondary: MyColors.secondary,
        tertiary: MyColors.tertiary,
        error: MyColors.error,
      );

  static TextTheme get textTheme => const TextTheme(
        displayLarge: MyTypography.displayLarge,
        displayMedium: MyTypography.displayMedium,
        displaySmall: MyTypography.displaySmall,
        headlineLarge: MyTypography.headlineLarge,
        headlineMedium: MyTypography.headlineMedium,
        headlineSmall: MyTypography.headlineSmall,
        titleLarge: MyTypography.titleLarge,
        titleMedium: MyTypography.titleMedium,
        titleSmall: MyTypography.titleSmall,
        bodyLarge: MyTypography.bodyLarge,
        bodyMedium: MyTypography.bodyMedium,
        bodySmall: MyTypography.bodySmall,
        labelLarge: MyTypography.labelLarge,
        labelMedium: MyTypography.labelMedium,
        labelSmall: MyTypography.labelSmall,
      ).apply(
        bodyColor: MyColors.black,
        displayColor: MyColors.black,
      );

  static InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      fillColor: MyColors.white,
      filled: true,
      hintStyle: textTheme.labelMedium?.copyWith(color: MyColors.grey.shade400),
      prefixIconColor: MyColors.grey.shade400,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: MyDimens.dp16,
        vertical: MyDimens.dp12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MyDimens.dp8),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MyDimens.dp8),
        borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MyDimens.dp8),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MyDimens.dp8),
        borderSide: BorderSide(color: colorScheme.error),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(MyDimens.dp8),
        borderSide: BorderSide(color: colorScheme.error),
      ),
    );
  }

  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      centerTitle: true,
      backgroundColor: colorScheme.primary,
      iconTheme: const IconThemeData(color: MyColors.primary),
    );
  }

  static ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MyDimens.dp4),
        ),
        backgroundColor: colorScheme.primary,
        foregroundColor: MyColors.white,
        textStyle: textTheme.titleMedium,
      ),
    );
  }

  static IconButtonThemeData get iconButtonTheme {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
    );
  }

  static CardTheme get cardTheme {
    return CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyDimens.dp8),
        side: BorderSide(color: MyColors.grey.shade100),
      ),
    );
  }

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
        colorScheme: colorScheme,
        primaryColor: colorScheme.primary,
        scaffoldBackgroundColor: MyColors.white,
        textTheme: textTheme,
        inputDecorationTheme: inputDecorationTheme,
        appBarTheme: appBarTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        iconButtonTheme: iconButtonTheme,
        cardTheme: cardTheme,
      );
}
