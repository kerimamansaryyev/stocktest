import 'package:stocktest/src/models/dto.dart';

class CompanyOverviewModelDTO extends ServerModelDTO<String> {
  static const _symbolKey = 'Symbol';
  static const _nameKey = 'Name';
  static const _capitalizationKey = 'MarketCapitalization';
  static const _currencyKey = 'Currency';

  const CompanyOverviewModelDTO({required Map<String, String> data})
      : super(data);

  String get _symbol => dtoRawModel[_symbolKey]?.toString() ?? '';
  String get _currency => dtoRawModel[_currencyKey]?.toString() ?? '';
  double get marketCapitalization => double.tryParse(_capitalizationKey) ?? 0;

  @override
  String get primaryKey => _symbol;

  String get name => dtoRawModel[_nameKey];
}
