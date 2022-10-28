import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stocktest/src/utils/cancelable_task_hierarchy.dart';

@immutable
mixin CancellableHttpTaskMixin<T> on HierarchialCancellableTask<T> {
  http.Client get client;

  @mustCallSuper
  @override
  Future<void> kill() async {
    client.close();
    return super.kill();
  }
}
