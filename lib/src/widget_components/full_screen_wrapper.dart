import 'package:flutter/widgets.dart';

/// A widget that is used to set [BoxConstraints] with [minHeight] above its [child]
class AppFullScreenWrapper extends StatelessWidget {
  final double minHeight;
  final Widget child;

  const AppFullScreenWrapper({
    required this.minHeight,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      child: child,
    );
  }
}
