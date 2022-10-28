import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stocktest/src/services/navigation_service/navigation_service.dart';
import 'package:stocktest/src/services/navigation_service/root_build_context_exposer.dart';
import 'package:stocktest/src/services/root_navigation_service.dart';
import 'package:stocktest/src/utils/theme/theme.dart';

class Zehinli extends StatefulWidget {
  const Zehinli({Key? key}) : super(key: key);

  @override
  State<Zehinli> createState() => _ZehinliState();
}

class _ZehinliState extends State<Zehinli> {
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
