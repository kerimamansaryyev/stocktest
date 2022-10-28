import 'package:flutter/widgets.dart';

@immutable
class AppNavigationArgument<T> {
  final String key;
  final T value;

  const AppNavigationArgument({
    required this.key,
    required this.value,
  });
}

class AppNavigationArgumentInjector {
  final Map<String, dynamic> _arguments = {};

  void inject<T>(AppNavigationArgument<T> argument) {
    _arguments.addAll({argument.key: argument.value});
  }

  T extract<T>(String key) => _arguments[key] as T;
}
