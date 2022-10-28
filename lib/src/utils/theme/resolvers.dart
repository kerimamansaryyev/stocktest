import 'package:adaptix/adaptix.dart';
import 'package:flutter/widgets.dart';

abstract class AdaptixResolvers {
  static BorderRadius resolveBorderRadius(
    BuildContext context,
    BorderRadius base,
  ) =>
      BorderRadius.only(
        topLeft: Radius.elliptical(
          base.topLeft.x.adaptedPx(context),
          base.topLeft.y.adaptedPx(context),
        ),
        topRight: Radius.elliptical(
          base.topRight.x.adaptedPx(context),
          base.topRight.y.adaptedPx(context),
        ),
        bottomLeft: Radius.elliptical(
          base.bottomLeft.x.adaptedPx(context),
          base.bottomLeft.y.adaptedPx(context),
        ),
        bottomRight: Radius.elliptical(
          base.bottomRight.x.adaptedPx(context),
          base.bottomRight.y.adaptedPx(context),
        ),
      );

  static EdgeInsets resolvePadding(BuildContext context, EdgeInsets base) =>
      EdgeInsets.only(
        left: base.left.adaptedPx(context),
        right: base.right.adaptedPx(context),
        top: base.top.adaptedPx(context),
        bottom: base.bottom.adaptedPx(context),
      );

  static Size resolveSize(BuildContext context, Size base) => Size(
        base.width.adaptedPx(context),
        base.height.adaptedPx(context),
      );
}
