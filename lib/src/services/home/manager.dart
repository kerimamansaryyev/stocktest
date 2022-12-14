import 'package:manager_provider/manager_provider.dart';
import 'package:meta/meta.dart';
import 'package:stocktest/src/models/company/company.dart';
import 'package:stocktest/src/models/company/company_overview.dart';
import 'package:stocktest/src/services/home/tasks.dart';
import 'package:stocktest/src/services/global_observers/task_fail_observer.dart';

/// A manager that fetches information about multiple companies (see [CompanyMetaData]) returning DTO models them in [HomeManagerState].
class HomeManager extends Manager<HomeManagerState>
    with ObservableManagerMixin {
  HomeManager() : super(const HomeManagerState._initial()) {
    addObserver(
      TaskFailObserver(),
    );
  }

  void getCompanyOverviews() => run(HomeGetOverviewsTask());
}

/// A state representation of [HomeManager].
@immutable
class HomeManagerState {
  final List<CompanyOverviewDTO> companyOverviews;
  final double overallCapitalization;

  const HomeManagerState({
    required this.companyOverviews,
    required this.overallCapitalization,
  });

  const HomeManagerState._initial()
      : this(
          companyOverviews: const [],
          overallCapitalization: 0,
        );

  String percentLabelOf(double companyMarketCapitalization) {
    final percentage =
        ((companyMarketCapitalization / overallCapitalization) * 100)
            .toStringAsFixed(1);
    return '$percentage%';
  }
}
