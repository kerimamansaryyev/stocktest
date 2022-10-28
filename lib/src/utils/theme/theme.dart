import 'package:flutter/cupertino.dart';
import 'package:stocktest/src/utils/theme/typography.dart';

typedef CupertinoThemeDataResolver = CupertinoThemeData Function(
  BuildContext,
);

enum AppThemes {
  light(_lightThemeDataResolver),
  dark(_darkThemeDataResolver);

  const AppThemes(
    this.resolver,
  );

  static const fallback = AppThemes.light;
  static const _defaultCupertinoTheme = CupertinoThemeData();

  @protected
  final CupertinoThemeDataResolver resolver;

  CupertinoThemeData resolve(BuildContext context) => resolver(context);

  static CupertinoThemeData _lightThemeDataResolver(BuildContext context) =>
      _defaultCupertinoTheme.copyWith(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: _defaultCupertinoTheme.textTheme.textStyle.copyWith(
            fontSize: AppTypographies.b2.style(context).fontSize,
          ),
        ),
      );

  static CupertinoThemeData _darkThemeDataResolver(BuildContext context) =>
      _defaultCupertinoTheme.copyWith(
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(
          textStyle: _defaultCupertinoTheme.textTheme.textStyle.copyWith(
            fontSize: AppTypographies.b2.style(context).fontSize,
          ),
        ),
      );
}
