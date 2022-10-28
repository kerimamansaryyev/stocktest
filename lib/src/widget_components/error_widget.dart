import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:stocktest/src/localization/extensions.dart';
import 'package:stocktest/src/utils/theme/theme.dart';

class AppErrorWidget extends StatelessWidget {
  final VoidCallback? tryAgain;
  final String? label;
  final bool includeBottomInset;
  final bool includeTopInset;

  const AppErrorWidget({
    super.key,
    this.tryAgain,
    this.label,
    this.includeBottomInset = false,
    this.includeTopInset = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: includeTopInset ? AppThemes.navbarHeight(context) : 0,
          bottom: includeBottomInset ? AppThemes.bottomInset(context) : 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label ?? context.translation.errorOccurred,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5.adaptedPx(context),
            ),
            if (tryAgain != null)
              CupertinoButton(
                onPressed: tryAgain,
                child: Text(
                  context.translation.tryAgain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
