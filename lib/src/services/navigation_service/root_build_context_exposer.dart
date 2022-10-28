import 'package:flutter/widgets.dart';

class RootBuildContextExposer {
  static RootBuildContextExposer? _singleton;

  BuildContext? context;

  RootBuildContextExposer._();

  factory RootBuildContextExposer.singleton() =>
      _singleton ??= RootBuildContextExposer._();
}
