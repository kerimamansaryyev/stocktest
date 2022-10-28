import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef AppNavigationRouteBuilder<A> = Widget Function(
  BuildContext context,
  A argument,
);

typedef AppNavigationRedirectBuilder<A> = AppNavigationRedirect? Function(
  BuildContext context,
  A parameters,
);

typedef RouteRemovePredicate = bool Function(
  Route route,
);

typedef ParametersValidationPredicate<A> = bool Function(
  BuildContext context,
  A paramters,
);

@immutable
class AppNavigationRedirect<T> {
  final AppNavigationRoute<T>? route;
  final T parameters;

  const AppNavigationRedirect({
    required this.route,
    required this.parameters,
  });
}

@immutable
abstract class AppNavigationRoute<A> {
  String get routeName;
  Widget builder(
    BuildContext context,
    A argument,
  );
  AppNavigationRedirect? redirect(
    BuildContext context,
    A parameters,
  );
}

abstract class AppNavigationService {
  BuildContext? get context;

  void push<T>(
    AppNavigationRoute<T> route, {
    required T parameters,
  });
  void pushReplacement<T>(
    AppNavigationRoute<T> route, {
    required T parameters,
  });
  void pushAndRemoveUntil<T>(
    AppNavigationRoute<T> route,
    RouteRemovePredicate predicate, {
    required T parameters,
  });

  void pop();

  @protected
  static AppNavigationRedirect getRecursiveRedirect<T>({
    required BuildContext context,
    required AppNavigationRoute<T>? route,
    required T parameters,
  }) {
    final redirect = route?.redirect(context, parameters);
    if (redirect == null) {
      return AppNavigationRedirect(route: route, parameters: parameters);
    } else {
      return getRecursiveRedirect(
        context: context,
        route: redirect.route,
        parameters: redirect.parameters,
      );
    }
  }

  static AppNavigationService of(BuildContext context) =>
      Provider.of<AppNavigationService>(context, listen: false);
}

class InternalAppNavigationRoute<T> implements AppNavigationRoute<T> {
  final AppNavigationRouteBuilder<T> builderFunction;
  final ParametersValidationPredicate<T>? parametersValidationPredicate;

  @override
  final String routeName;

  const InternalAppNavigationRoute({
    required this.builderFunction,
    required this.routeName,
    this.parametersValidationPredicate,
  }) : super();

  @override
  Widget builder(BuildContext context, T argument) =>
      builderFunction(context, argument);

  @override
  AppNavigationRedirect? redirect(BuildContext context, T parameters) =>
      _validateParamters(context, parameters)
          ? null
          : const AppNavigationRedirect<void>(
              route: null,
              parameters: null,
            );

  bool _validateParamters(BuildContext context, T parameters) =>
      parametersValidationPredicate?.call(context, parameters) ?? true;
}
