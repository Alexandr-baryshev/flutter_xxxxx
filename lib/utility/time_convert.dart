import 'package:intl/intl.dart';

/// Принимает время в миллисекундах, и временной паттрн. Возвращает строку времени.
/// 'd.M.yyyy  H:mm'
String time(int milliseconds, String pattern) {
  if (milliseconds == null) {
    milliseconds = DateTime.now().millisecondsSinceEpoch;
  }
  DateTime newDate = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  var format = new DateFormat(pattern);
  return format.format(newDate);
}