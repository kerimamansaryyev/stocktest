import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stocktest/src/utils/exceptions/exception.dart';
import 'package:stocktest/src/utils/misc.dart';

typedef JsonSuccessHandler<T> = FutureOr<T> Function(dynamic decodedResponse);
typedef JsonErrorHandler = void Function(
  dynamic exception,
  StackTrace? stackTrace,
);
typedef ApiRequestCallBuilder = ApiRequestCall Function();

class ApiRequestCall {
  static ApiRequestCallBuilder? _testBuilder;

  factory ApiRequestCall() {
    return _testBuilder?.call() ?? ApiRequestCall._();
  }

  ApiRequestCall._();

  static FutureOr<T> jsonValidatorMiddleware<T>(
    http.Response response, {
    required JsonSuccessHandler<T> onSuccess,
  }) {
    final decoded = jsonDecode(response.body);
    final success = boolParser(decoded['success']);
    if (!success) {
      throw AppException.recognizer(decoded);
    }

    return onSuccess(decoded);
  }

  @visibleForTesting
  static void injectTestBuilder(ApiRequestCallBuilder? builder) {
    _testBuilder = builder;
  }
}
