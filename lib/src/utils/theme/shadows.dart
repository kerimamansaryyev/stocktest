import 'package:flutter/widgets.dart';
import 'package:stocktest/src/utils/theme/colors.dart';

enum AppBoxShadows implements BoxShadow {
  tileLight(
    shadow: BoxShadow(
      color: AppColor.tileShadowLight,
      offset: Offset(2, 2),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  );

  final BoxShadow shadow;

  const AppBoxShadows({required this.shadow});

  @override
  double get blurRadius => shadow.blurRadius;

  @override
  double get blurSigma => shadow.blurSigma;

  @override
  BlurStyle get blurStyle => shadow.blurStyle;

  @override
  Color get color => shadow.color;

  @override
  Offset get offset => shadow.offset;

  @override
  BoxShadow scale(double factor) => shadow.scale(factor);

  @override
  double get spreadRadius => shadow.spreadRadius;

  @override
  Paint toPaint() => shadow.toPaint();
}
