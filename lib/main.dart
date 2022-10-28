import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stocktest/src/localization/localization_service.dart';
import 'package:stocktest/src/services/navigation_service/navigation_service.dart';
import 'package:stocktest/src/services/navigation_service/root_build_context_exposer.dart';
import 'package:stocktest/src/services/navigation_service/root_navigation_service.dart';
import 'package:stocktest/src/utils/theme/theme.dart';

void main() {
  runApp(const StockTestApp());
}

/// A starting point of the application
class StockTestApp extends StatefulWidget {
  const StockTestApp({Key? key}) : super(key: key);

  @override
  State<StockTestApp> createState() => _StockTestState();
}

class _StockTestState extends State<StockTestApp> {
  final GlobalKey<NavigatorState> _navigationGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    AppRootNavigationService.singleton()
        .bindWithNavigatorKey(_navigationGlobalKey);
  }

  @override
  Widget build(BuildContext context) {
    return AdaptixInitializer(
      configs: const AdaptixConfigs.canonical(),
      builder: (context) => CupertinoApp(
        theme: AppThemes.light.resolve(context),
        locale: const Locale('en'),
        supportedLocales: LocalizationService.supportedLocales,
        localizationsDelegates: LocalizationService.delegates,
        navigatorKey: _navigationGlobalKey,
        builder: (context, child) {
          return Provider<AppNavigationService>.value(
            value: AppRootNavigationService.singleton(),
            child: Builder(
              builder: (context) {
                RootBuildContextExposer.singleton().context = context;
                return child!;
              },
            ),
          );
        },
        home: AppRootNavigationRoutes.home.builder(
          context,
          null,
        ),
      ),
    );
  }
}
