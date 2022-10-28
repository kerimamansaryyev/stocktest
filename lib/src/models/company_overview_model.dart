import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stocktest/src/models/dto.dart';
import 'package:stocktest/src/utils/number_labels.dart';

enum CompanyMetaData {
  apple(
    symbol: 'AAPL',
    color: Colors.blue,
  ),
  google(
    symbol: 'GOOG',
    color: Colors.green,
  ),
  microsoft(
    symbol: 'MSFT',
    color: Colors.yellow,
  );

  final Color color;
  final String symbol;

  const CompanyMetaData({
    required this.symbol,
    required this.color,
  });
}

@internal
class CompanyModelDTO extends ServerModelDTO<String> {
  static const _symbolKey = 'Symbol';
  static const _nameKey = 'Name';
  static const _capitalizationKey = 'MarketCapitalization';
  static const _currencyKey = 'Currency';

  const CompanyModelDTO({required Map<String, dynamic> data}) : super(data);

  String get _symbol => dtoRawModel[_symbolKey]?.toString() ?? '';
  String get _currency => dtoRawModel[_currencyKey]?.toString() ?? '';
  double get marketCapitalization =>
      double.tryParse(dtoRawModel[_capitalizationKey]?.toString() ?? '') ?? 0;

  @override
  String get primaryKey => _symbol;

  String get name => dtoRawModel[_nameKey];
}

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
    final currency = model._currency;

    return CompanyOverviewDTO._(
      color: color,
      marketCapitalization: model.marketCapitalization,
      marketCapitalizationLabel:
          '${NumberLabel.convert(capitalization)} $currency',
      name: model.name,
    );
  }
}
