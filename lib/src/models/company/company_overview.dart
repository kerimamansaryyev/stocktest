import 'package:flutter/widgets.dart';
import 'package:stocktest/src/models/company/company.dart';
import 'package:stocktest/src/utils/number_labels.dart';

class CompanyOverviewDTO {
  final String name;
  final double marketCapitalization;
  final String marketCapitalizationLabel;
  final Color color;

  CompanyOverviewDTO._({
    required this.marketCapitalization,
    required this.marketCapitalizationLabel,
    required this.color,
    required this.name,
  });

  factory CompanyOverviewDTO.fromMap({
    required Map<String, dynamic> data,
    required Color color,
  }) {
    final model = CompanyModelDTO(data: data);
    final capitalization = model.marketCapitalization;
    final currency = model.currency;

    return CompanyOverviewDTO._(
      color: color,
      marketCapitalization: model.marketCapitalization,
      marketCapitalizationLabel:
          '${NumberLabel.convert(capitalization)} $currency',
      name: model.name,
    );
  }
}
