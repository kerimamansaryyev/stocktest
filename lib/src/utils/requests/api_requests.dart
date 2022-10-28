import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stocktest/data.secrets.dart';

typedef JsonSuccessHandler<T> = FutureOr<T> Function(dynamic decodedResponse);
typedef JsonResponseValidator = dynamic Function(dynamic decodedResponse);

@visibleForTesting
typedef ApiRequestCallBuilder = ApiRequestCall Function();

/// A class is that used to make http requests.
///
/// A [_testBuilder] singleton can be injected by [injectTestBuilder] in test environments.
class ApiRequestCall {
  static ApiRequestCallBuilder? _testBuilder;

  factory ApiRequestCall() {
    return _testBuilder?.call() ?? ApiRequestCall._();
  }

  ApiRequestCall._();

  Future<http.Response> getCompanyOverview(
    http.Client client, {
    required String symbol,
  }) {
    return client.get(
      alphavantageUri(
        path: '/query',
        queryParameters: {
          'function': 'OVERVIEW',
          'symbol': symbol,
          'apikey': alphavantageApiKey,
        },
      ),
    );
  }

  static FutureOr<T> jsonParser<T>(
    http.Response response, {
    required JsonSuccessHandler<T> onSuccess,
  }) {
    final decoded = jsonDecode(response.body);
    return onSuccess(decoded);
  }

  @visibleForTesting
  static void injectTestBuilder(ApiRequestCallBuilder? builder) {
    _testBuilder = builder;
  }

  static Uri alphavantageUri({
    Map<String, String>? queryParameters,
    String? path,
  }) =>
      Uri(
        scheme: 'https',
        host: 'alphavantage.co',
        queryParameters: queryParameters,
        path: path,
      );
}
