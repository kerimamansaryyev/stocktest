import 'package:manager_provider/manager_provider.dart';
import 'package:meta/meta.dart';
import 'package:stocktest/src/models/company/company_details.dart';
import 'package:stocktest/src/services/company_details/tasks.dart';

class CompanyDetailsManager extends Manager<CompanyDetailsManagerState> {
  CompanyDetailsManager() : super(const CompanyDetailsManagerState._initial());

  void getDetails(String symbol) => run(
        CompanyDetailsGetDataTask(companySymbol: symbol),
      );
}

@immutable
class CompanyDetailsManagerState {
  final CompanyDetailsDTO? detailsDTO;

  const CompanyDetailsManagerState({
    required this.detailsDTO,
  });

  const CompanyDetailsManagerState._initial()
      : this(
          detailsDTO: null,
        );
}
