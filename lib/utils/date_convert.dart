import 'package:intl/intl.dart';

String dateConverter(String date) {
  const String format = 'HH:mm dd MMMM yyyy';

  return DateFormat(format).format(DateTime.parse(date));
}
