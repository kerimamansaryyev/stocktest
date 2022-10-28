import 'package:flutter/widgets.dart';
import 'package:stocktest/src/models/company/company.dart';
import 'package:stocktest/src/services/home/manager.dart';
import 'package:stocktest/src/utils/number_labels.dart';

/// A data transfer object derived from [CompanyModelDTO] for [HomeManagerState]
class CompanyOverviewDTO {
  final String name;
  final double marketCapitalization;
  final String marketCapitalizationLabel;
  final Color color;
  final String symbol;

  CompanyOverviewDTO._({
    required this.marketCapitalization,
    required this.marketCapitalizationLabel,
    required this.color,
    required this.name,
    required this.symbol,
  });

  factory CompanyOverviewDTO.fromMap({
    required Map<String, dynamic> data,
    required Color color,
  }) {
    final model = CompanyModelDTO(data: data);
    final capitalization = model.marketCapitalization;
    final currency = model.currency;

    return CompanyOverviewDTO._(
      symbol: model.primaryKey,
      color: color,
      marketCapitalization: model.marketCapitalization,
      marketCapitalizationLabel:
          '${NumberLabel.convert(capitalization)}$currency',
      name: model.name,
    );
  }
}
