/// A class that is used to prettyfing big numbers.
enum NumberLabel {
  _unlabeled(
    label: null,
    threshold: 0,
    next: _thousand,
    fraction: 0,
  ),
  _thousand(
    label: 'k',
    threshold: 1000,
    next: _million,
    fraction: 1,
  ),
  _million(
    label: 'M',
    threshold: 1000000,
    next: _billion,
    fraction: 2,
  ),
  _billion(
    label: 'B',
    threshold: 1000000000,
    next: _trillion,
    fraction: 2,
  ),
  _trillion(
    label: 'T',
    threshold: 1000000000000,
    next: null,
    fraction: 3,
  );

  final String? label;
  final int threshold;
  final int fraction;
  final NumberLabel? next;

  const NumberLabel({
    required this.label,
    required this.threshold,
    required this.next,
    required this.fraction,
  });

  factory NumberLabel._identify(double bigNumber) {
    for (var value in values) {
      final isBiggerOrEqualToThis = bigNumber >= value.threshold;
      final isLessThenNext =
          value.next != null && bigNumber < value.next!.threshold;

      if (isBiggerOrEqualToThis && isLessThenNext) {
        return value;
      }
    }
    return NumberLabel._trillion;
  }

  static String convert(double bigNumber) {
    final value = NumberLabel._identify(bigNumber);

    return value.label == null
        ? bigNumber.toString()
        : '${(bigNumber / value.threshold).toStringAsFixed(value.fraction)} ${value.label}';
  }
}
