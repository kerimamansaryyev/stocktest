import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:stocktest/src/utils/theme/typography.dart';

typedef CupertinoThemeDataResolver = CupertinoThemeData Function(
  BuildContext,
);

enum AppThemes {
  light(_lightCupertinoThemeDataResolver);

  const AppThemes(
    this.resolver,
  );

  static const fallback = AppThemes.light;
  static const _defaultCupertinoTheme = CupertinoThemeData();

  @protected
  final CupertinoThemeDataResolver resolver;

  CupertinoThemeData resolve(BuildContext context) => resolver(context);

  static CupertinoThemeData _lightCupertinoThemeDataResolver(
    BuildContext context,
  ) =>
      _defaultCupertinoTheme.copyWith(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: _defaultCupertinoTheme.textTheme.textStyle.copyWith(
            fontSize: AppTypographies.b2.style(context).fontSize,
          ),
        ),
      );

  static EdgeInsets bodyContentPadding(BuildContext context) =>
      EdgeInsets.symmetric(
        horizontal: 3.widthFraction(context),
      );

  static double navbarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottomInset(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;
}
