import 'package:flutter/material.dart';

enum AppColor implements Color {
  primaryLight(color: Color.fromRGBO(42, 142, 243, 1)),
  scaffoldLight(color: Color.fromRGBO(243, 248, 255, 1)),

  tileBackgroundColorLight(color: Colors.white),
  tileShadowLight(
    color: Color.fromRGBO(223, 235, 248, 0.5),
  );

  const AppColor({required this.color});

  @protected
  final Color color;

  @visibleForTesting
  Color get colorTest => color;

  @override
  int get alpha => color.alpha;

  @override
  int get blue => color.blue;

  @override
  double computeLuminance() => color.computeLuminance();

  @override
  int get green => color.green;

  @override
  double get opacity => color.opacity;

  @override
  int get red => color.red;

  @override
  int get value => color.value;

  @override
  Color withAlpha(int a) => color.withAlpha(a);

  @override
  Color withBlue(int b) => color.withBlue(b);
  @override
  Color withGreen(int g) => color.withGreen(g);

  @override
  Color withOpacity(double opacity) => color.withOpacity(opacity);

  @override
  Color withRed(int r) => color.withRed(r);
}
