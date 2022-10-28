import 'package:intl/intl.dart';

bool boolParser(dynamic object) =>
    object == true || object == 'true' || object == 1 || object == '1';

Map<String, dynamic> leaveOnlyStringKeys(Map other) {
  final copy = {...other}..removeWhere((key, value) => key is! String);
  return {...copy};
}

List safelyGetListFromDynamic(dynamic data) {
  if (data is! Iterable) {
    return [];
  }

  return [...data];
}

Map safelyGetMapFromDynamic(dynamic data) {
  if (data is! Map) {
    return {};
  }

  return {...data};
}

String durationFormatter(Duration duration) {
  if (duration.isNegative) {
    return '00:00';
  }

  String padded(int value) => value.toString().padLeft(2, '0');
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  return '${padded(minutes)}:${padded(seconds)}';
}

extension DateTimeFormatExtension on DateTime? {
  String? formatByDateFormat(String format, String locale) {
    if (this is! DateTime) {
      return null;
    } else {
      return DateFormat(format, locale).format(this!);
    }
  }
}
