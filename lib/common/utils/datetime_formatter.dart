import 'package:intl/intl.dart';

String formatDate(DateTime dateTime, String pattern) {
  final DateFormat formatter = DateFormat(pattern, 'id_ID');
  return formatter.format(dateTime);
}

DateTime parseDate(String dateString, String pattern) {
  final DateFormat parser = DateFormat(pattern, 'id_ID');
  return parser.parse(dateString);
}

extension DateTimeExtension on DateTime? {
  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return false;
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return false;
  }

  bool isBetween(
    DateTime startDateTime,
    DateTime endDateTime,
  ) {
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(startDateTime);
      final isBefore = date.isBeforeOrEqualTo(endDateTime);
      return isAfter && isBefore;
    }
    return false;
  }
}
