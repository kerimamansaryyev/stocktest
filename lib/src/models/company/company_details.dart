import 'package:flutter/widgets.dart';
import 'package:stocktest/src/localization/extensions.dart';
import 'package:stocktest/src/models/company/company.dart';
import 'package:stocktest/src/services/company_details/manager.dart';
import 'package:stocktest/src/utils/number_labels.dart';

/// A data transfer object derived from [CompanyModelDTO] for [CompanyDetailsManagerState]
class CompanyDetailsDTO {
  final String name;
  final double marketCapitalization;
  final String marketCapitalizationLabel;
  final String symbol;
  final String address;
  final String sector;
  final String industry;

  CompanyDetailsDTO._({
    required this.address,
    required this.industry,
    required this.sector,
    required this.marketCapitalization,
    required this.marketCapitalizationLabel,
    required this.name,
    required this.symbol,
  });

  factory CompanyDetailsDTO.fromMap({
    required Map<String, dynamic> data,
  }) {
    final model = CompanyModelDTO(data: data);
    final capitalization = model.marketCapitalization;
    final currency = model.currency;

    return CompanyDetailsDTO._(
      sector: model.sector,
      industry: model.industry,
      address: model.address,
      symbol: model.primaryKey,
      marketCapitalization: model.marketCapitalization,
      marketCapitalizationLabel:
          '${NumberLabel.convert(capitalization)}$currency',
      name: model.name,
    );
  }

  Map<String, String> dataRows(BuildContext context) => {
        context.translation.companySymbolLabel: symbol,
        context.translation.companyMarketCapitalizationLabel:
            marketCapitalizationLabel,
        context.translation.companySectorLabel: sector,
        context.translation.companyIndustryLabel: industry,
      };
}
