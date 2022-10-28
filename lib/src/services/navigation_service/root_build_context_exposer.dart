import 'package:flutter/widgets.dart';

/// A singleton class that exposes the highest [context] of the project.
class RootBuildContextExposer {
  static RootBuildContextExposer? _singleton;

  BuildContext? context;

  RootBuildContextExposer._();

  factory RootBuildContextExposer.singleton() =>
      _singleton ??= RootBuildContextExposer._();
}
