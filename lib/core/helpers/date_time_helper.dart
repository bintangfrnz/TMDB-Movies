import 'package:intl/intl.dart';

class DateTimeHelper {
  static final _dateOutputFormat = DateFormat('MMM d, yyyy');

  static String parse(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return _dateOutputFormat.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}
