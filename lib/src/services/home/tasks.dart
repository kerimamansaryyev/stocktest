import 'package:http/http.dart' as http;
import 'package:manager_provider/manager_provider.dart';
import 'package:stocktest/src/models/company/company.dart';
import 'package:stocktest/src/models/company/company_overview.dart';
import 'package:stocktest/src/services/home/manager.dart';
import 'package:stocktest/src/utils/cancelable_task_hierarchy.dart';
import 'package:stocktest/src/utils/exceptions/exception.dart';
import 'package:stocktest/src/utils/misc.dart';
import 'package:stocktest/src/utils/requests/api_requests.dart';
import 'package:stocktest/src/utils/requests/cancellable_http_task.dart';

/// Task that makes multiple requests and unifies responses with an overview information about
/// companies.
///
/// See also: [CompanyMetaData]
class HomeGetOverviewsTask extends AsynchronousTask<HomeManagerState>
    with
        CancelableAsyncTaskMixin,
        HierarchialCancellableTask,
        CancellableHttpTaskMixin {
  static const taskId = 'get_overview';

  @override
  final http.Client client = http.Client();

  @override
  String get id => taskId;

  @override
  Future<HomeManagerState> run() async {
    double capitalizationCount = 0;
    final overviews = (await _getOverviews(client))
      ..forEach((element) {
        capitalizationCount += element.marketCapitalization;
      });

    return HomeManagerState(
      companyOverviews: overviews,
      overallCapitalization: capitalizationCount,
    );
  }

  static Future<List<CompanyOverviewDTO>> _getOverviews(
    http.Client client,
  ) async {
    return <CompanyOverviewDTO>[
      for (var metaData in CompanyMetaData.values)
        await ApiRequestCall.jsonParser<CompanyOverviewDTO>(
          await ApiRequestCall().getCompanyOverview(
            client,
            symbol: metaData.symbol,
          ),
          onSuccess: (responseDecoded) {
            if (responseDecoded is! Map) {
              throw const OtherException();
            } else if (responseDecoded.length == 1) {
              final note = responseDecoded['Note'];
              if (note is! String) {
                throw const OtherException();
              }
              throw GenericMessageException(
                message: note,
              );
            }
            return CompanyOverviewDTO.fromMap(
              data: leaveOnlyStringKeys(responseDecoded),
              color: metaData.color,
            );
          },
        )
    ];
  }
}
