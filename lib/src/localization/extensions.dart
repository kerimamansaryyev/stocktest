import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:stocktest/src/localization/localization_service.dart';
import 'package:stocktest/src/utils/exceptions/exception.dart';

extension LocalizationTranslationExtension on BuildContext {
  AppLocalizations get translation {
    final trnsl = LocalizationService.translation(this);
    if (trnsl == null) {
      throw AppLocalizationNotFoundException();
    }
    return trnsl;
  }
}
