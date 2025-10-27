import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(final DateTime date) {
    final localeDate = date.toLocal();

    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(localeDate);
  }

  static String formatTime(final DateTime date) {
    final localeDate = date.toLocal();

    final formatter = DateFormat('hh:mm aa');
    return formatter.format(localeDate);
  }

  static String formatDateTime(final DateTime date) {
    final localeDate = date.toLocal();

    final formatter = DateFormat('hh:mm aa, dd MMM yyyy');
    return formatter.format(localeDate);
  }

  static String convertWeekdayToDDD(final int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
