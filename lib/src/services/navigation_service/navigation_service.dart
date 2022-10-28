import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:stocktest/src/services/navigation_service/global_key_navigation_service_implementation.dart';

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

/// A special structure that is used to tell [AppNavigationService] to redirect on calling its methods.
///
/// See also: [GlobalKeyNavigationImplementation], [AppNavigationService.getRecursiveRedirect],
@immutable
class AppNavigationRedirect<T> {
  final AppNavigationRoute<T>? route;
  final T parameters;

  const AppNavigationRedirect({
    required this.route,
    required this.parameters,
  });
}

/// A route that is passed to the methods of [AppNavigationService]
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

/// An abstract interface of the project's navigation.
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
