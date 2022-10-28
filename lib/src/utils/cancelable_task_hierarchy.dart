import 'package:manager_provider/manager_provider.dart';
import 'package:meta/meta.dart';

/// A transition interface for the classes implementing [CancelableAsyncTaskMixin]
@immutable
mixin HierarchialCancellableTask<T> on CancelableAsyncTaskMixin<T> {
  @mustCallSuper
  @override
  Future<void> kill() async {}
}
