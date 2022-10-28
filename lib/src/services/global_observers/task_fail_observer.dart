import 'package:manager_provider/manager_provider.dart';
import 'package:stocktest/src/utils/exceptions/exception.dart';

/// Observes managers and identitfies [TaskErrorEvent]s notifying the stream calling [AppException.exceptionHandler]
class TaskFailObserver extends ManagerObserver {
  @override
  void onEvent(Manager manager, TaskEvent event) {
    ManagerObserver.doIfEventIs<TaskErrorEvent>(event, (event) {
      AppException.exceptionHandler(event.exception);
    });
  }
}
