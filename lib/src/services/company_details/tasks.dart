import 'package:http/http.dart' as http;
import 'package:manager_provider/manager_provider.dart';
import 'package:stocktest/src/models/company/company_details.dart';
import 'package:stocktest/src/services/company_details/manager.dart';
import 'package:stocktest/src/utils/cancelable_task_hierarchy.dart';
import 'package:stocktest/src/utils/exceptions/exception.dart';
import 'package:stocktest/src/utils/misc.dart';
import 'package:stocktest/src/utils/requests/api_requests.dart';
import 'package:stocktest/src/utils/requests/cancellable_http_task.dart';

/// A task that takes [companySymbol] and fetches an information of the company accordingly from API.
class CompanyDetailsGetDataTask
    extends AsynchronousTask<CompanyDetailsManagerState>
    with
        CancelableAsyncTaskMixin,
        HierarchialCancellableTask,
        CancellableHttpTaskMixin {
  static const taskId = 'get_details';

  final String companySymbol;

  @override
  final http.Client client = http.Client();

  CompanyDetailsGetDataTask({
    required this.companySymbol,
  });

  @override
  String get id => taskId;

  @override
  Future<CompanyDetailsManagerState> run() async {
    return CompanyDetailsManagerState(
      detailsDTO: await _getOverviews(
        client,
        symbol: companySymbol,
      ),
    );
  }

  static Future<CompanyDetailsDTO> _getOverviews(
    http.Client client, {
    required String symbol,
  }) async {
    return ApiRequestCall.jsonParser<CompanyDetailsDTO>(
      await ApiRequestCall().getCompanyOverview(
        client,
        symbol: symbol,
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
        return CompanyDetailsDTO.fromMap(
          data: leaveOnlyStringKeys(responseDecoded),
        );
      },
    );
  }
}
