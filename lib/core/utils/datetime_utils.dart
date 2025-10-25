import 'package:intl/intl.dart';

class DatetimeUtils {
  static String? fromDateTimeToString(DateTime? dateTime) {
    if (dateTime == null) return null;
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static DateTime? fromStringToDateTime(String? dateTimeString) {
    if (dateTimeString == null) return null;
    return DateTime.parse(dateTimeString);
  }
}
