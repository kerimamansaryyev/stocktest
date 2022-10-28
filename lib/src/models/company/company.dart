import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stocktest/src/models/company/company_details.dart';
import 'package:stocktest/src/models/company/company_overview.dart';
import 'package:stocktest/src/models/dto.dart';

/// The metadata is used as parameters to fetch the information about companies
/// through the API
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

/// A model DTO that is used only on Application layer as a DTO(data transfer object)
/// for [CompanyOverviewDTO] and [CompanyDetailsDTO]
@internal
class CompanyModelDTO extends ServerModelDTO<String> {
  static const _symbolKey = 'Symbol';
  static const _nameKey = 'Name';
  static const _capitalizationKey = 'MarketCapitalization';
  static const _currencyKey = 'Currency';
  static const _sectorKey = 'Sector';
  static const _industryKey = 'Industry';
  static const _addressKey = 'address';

  const CompanyModelDTO({required Map<String, dynamic> data}) : super(data);

  String get _symbol => dtoRawModel[_symbolKey]?.toString() ?? '';
  String get currency => dtoRawModel[_currencyKey]?.toString() ?? '';
  double get marketCapitalization =>
      double.tryParse(dtoRawModel[_capitalizationKey]?.toString() ?? '') ?? 0;

  @override
  String get primaryKey => _symbol;

  String get name => dtoRawModel[_nameKey];

  String get industry => dtoRawModel[_industryKey]?.toString() ?? '';

  String get sector => dtoRawModel[_sectorKey]?.toString() ?? '';

  String get address => dtoRawModel[_addressKey]?.toString() ?? '';
}
