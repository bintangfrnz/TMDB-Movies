import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb_movies/config/navigation/index.dart';
import 'package:tmdb_movies/core/extensions/theme_ext.dart';
import 'package:tmdb_movies/core/resources/index.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
      (_) => MyNav.pushNamedAndRemoveUntil(MyRoutes.homeRoute, (route) => false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _buildConsent(context),
          _buildSplashLogo(context),
          _buildCopyright(context),
        ],
      ),
    );
  }

  Positioned _buildConsent(BuildContext context) {
    return Positioned.fill(
      left: MyDimens.width(context) / 4,
      right: MyDimens.width(context) / 4,
      child: SvgPicture.asset(MyAssets.logoFull),
    );
  }

  Positioned _buildSplashLogo(BuildContext context) {
    return Positioned(
      top: 64,
      child: Text(
        "For development purposes only",
        style: context.theme.textTheme.titleLarge?.copyWith(
          color: MyColors.grey.shade400,
        ),
      ),
    );
  }

  Positioned _buildCopyright(BuildContext context) {
    return Positioned(
      bottom: 32,
      child: Text("© 2024 bintang", style: context.theme.textTheme.labelLarge),
    );
  }
}
