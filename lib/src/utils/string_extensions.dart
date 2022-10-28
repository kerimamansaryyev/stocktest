import 'package:characters/characters.dart';

extension UtilStringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    } else if (length == 1) {
      return toUpperCase();
    }

    final firstLetter = this[0].toUpperCase();
    final other = substring(1, length).toLowerCase();

    return '$firstLetter$other';
  }

  String get noBreaks => Characters(this)
      .replaceAll(Characters(''), Characters('\u{200B}'))
      .toString();
}
