import 'package:flutter/material.dart';
import 'package:stocktest/src/services/navigation_service/navigation_service.dart';

/// An implementation of navigation using [GlobalKey] with [NavigatorState] via [navigatorKey].
mixin GlobalKeyNavigationImplementation on AppNavigationService {
  @protected
  GlobalKey<NavigatorState>? navigatorKey;

  @override
  BuildContext? get context => navigatorKey?.currentContext;

  void bindWithNavigatorKey(GlobalKey<NavigatorState> other) {
    navigatorKey = other;
  }

  @override
  void push<T>(
    AppNavigationRoute<T> route, {
    required T parameters,
  }) {
    final redirect = AppNavigationService.getRecursiveRedirect<T>(
      context: context!,
      route: route,
      parameters: parameters,
    );
    final redirectedRoute = redirect.route;

    if (redirectedRoute == null) {
      return;
    }

    final redirectedParameters = redirect.parameters;

    navigatorKey?.currentState?.push<Map<String, String>?>(
      MaterialPageRoute(
        builder: (context) => redirectedRoute.builder(
          context,
          redirectedParameters,
        ),
      ),
    );
  }

  @override
  void pop() {
    navigatorKey?.currentState?.pop();
  }

  @override
  void pushReplacement<T>(
    AppNavigationRoute<T> route, {
    required T parameters,
  }) {
    final redirect = AppNavigationService.getRecursiveRedirect<T>(
      context: context!,
      route: route,
      parameters: parameters,
    );
    final redirectedRoute = redirect.route;

    if (redirectedRoute == null) {
      return;
    }

    final redirectedParameters = redirect.parameters;

    navigatorKey?.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => redirectedRoute.builder(
          context,
          redirectedParameters,
        ),
      ),
    );
  }

  @override
  void pushAndRemoveUntil<T>(
    route,
    RouteRemovePredicate predicate, {
    required T parameters,
  }) {
    final redirect = AppNavigationService.getRecursiveRedirect<T>(
      context: context!,
      route: route,
      parameters: parameters,
    );
    final redirectedRoute = redirect.route;

    if (redirectedRoute == null) {
      return;
    }

    final redirectedParameters = redirect.parameters;

    navigatorKey?.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => redirectedRoute.builder(
          context,
          redirectedParameters,
        ),
      ),
      predicate,
    );
  }
}
