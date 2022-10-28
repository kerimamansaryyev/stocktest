import 'dart:async';

import 'package:stocktest/src/localization/extensions.dart';
import 'package:stocktest/src/services/navigation_service/root_build_context_exposer.dart';

abstract class AppException implements Exception {
  static final StreamController<AppException> _onExceptionController =
      StreamController.broadcast();

  factory AppException.recognizer(Object? result) {
    if (result is! Map) {
      return const OtherException();
    }

    final data = result['data'];
    final message = data?['message'];

    if (message is String) {
      return ServerErrorException(data: data);
    }

    return const OtherException();
  }

  static Stream<T> onException<T extends AppException>() =>
      _onExceptionController.stream.where((event) => event is T).cast<T>();

  static void exceptionHandler(dynamic exception) {
    if (exception is! AppException) {
      _onExceptionController.add(const OtherException());
      return;
    }

    _onExceptionController.add(exception);
  }
}

abstract class GenericMessageException implements AppException {
  String get message;
}

class AppLocalizationNotFoundException implements AppException {}

class OtherException implements GenericMessageException {
  const OtherException();

  @override
  String get message {
    final context = RootBuildContextExposer.singleton().context;
    if (context != null) {
      return context.translation.errorOccurred;
    }

    return '';
  }
}

class ServerErrorException implements GenericMessageException {
  final Map<String, dynamic> data;

  const ServerErrorException({required this.data});

  @override
  String get message => data['message']?.toString() ?? '';
}
