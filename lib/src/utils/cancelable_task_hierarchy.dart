import 'package:manager_provider/manager_provider.dart';
import 'package:meta/meta.dart';

@immutable
mixin HierarchialCancellableTask<T> on CancelableAsyncTaskMixin<T> {
  @mustCallSuper
  @override
  Future<void> kill() async {}
}
