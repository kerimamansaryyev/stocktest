import 'package:flutter/widgets.dart';
import 'package:stocktest/src/screens/company_details/company_details.dart';
import 'package:stocktest/src/screens/home/home.dart';
import 'package:stocktest/src/services/navigation_service/global_key_navigation_service_implementation.dart';
import 'package:stocktest/src/services/navigation_service/navigation_service.dart';

abstract class _Builders {
  static Widget _homeBuilder(
    BuildContext context,
    Map<String, String>? parameters,
  ) =>
      const HomeScreen();

  static Widget _companyDetailsBuilder(
    BuildContext context,
    Map<String, String>? parameters,
  ) =>
      CompanyDetailsScreen(
        symbol:
            parameters![AppRootNavigationRoutes.companyDetailsParameterKey]!,
      );
}

abstract class _Redirects {
  static AppNavigationRedirect<void>?
      _companyDetailsParametersValidatorMiddleware(
    context,
    Map<String, String>? parameters,
  ) {
    final parameter =
        parameters?[AppRootNavigationRoutes.companyDetailsParameterKey];
    if (parameter == null) {
      return const AppNavigationRedirect(
        route: null,
        parameters: null,
      );
    }

    return null;
  }
}

enum AppRootNavigationRoutes
    implements AppNavigationRoute<Map<String, String>?> {
  home(
    builderFunction: _Builders._homeBuilder,
    routeName: '/home',
    redirectBuilderFunction: null,
  ),

  companyDetails(
    builderFunction: _Builders._companyDetailsBuilder,
    routeName: '/details',
    redirectBuilderFunction:
        _Redirects._companyDetailsParametersValidatorMiddleware,
  );

  final AppNavigationRouteBuilder<Map<String, String>?> builderFunction;
  final AppNavigationRedirectBuilder<Map<String, String>?>?
      redirectBuilderFunction;

  @override
  final String routeName;

  const AppRootNavigationRoutes({
    required this.builderFunction,
    required this.routeName,
    this.redirectBuilderFunction,
  });

  @override
  AppNavigationRedirect? redirect(
    BuildContext context,
    Map<String, String>? parameters,
  ) =>
      redirectBuilderFunction?.call(
        context,
        parameters,
      );

  @override
  Widget builder(BuildContext context, Map<String, String>? argument) =>
      builderFunction(context, argument);

  static const companyDetailsParameterKey = 'symbol';
}

class AppRootNavigationService extends AppNavigationService
    with GlobalKeyNavigationImplementation {
  static AppRootNavigationService? _singleton;

  AppRootNavigationService._();

  factory AppRootNavigationService.singleton() =>
      _singleton ??= AppRootNavigationService._();
}
