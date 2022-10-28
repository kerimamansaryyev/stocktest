import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stocktest/src/models/dto.dart';

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
  String get currency => dtoRawModel[_currencyKey]?.toString() ?? '';
  double get marketCapitalization =>
      double.tryParse(dtoRawModel[_capitalizationKey]?.toString() ?? '') ?? 0;

  @override
  String get primaryKey => _symbol;

  String get name => dtoRawModel[_nameKey];
}
