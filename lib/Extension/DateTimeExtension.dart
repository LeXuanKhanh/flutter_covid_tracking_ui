import 'package:intl/intl.dart';

enum DateTimeFormatType {
  fullDate,
}

extension DateTimeFormatTypeExtension on DateTimeFormatType {
  // ignore: missing_return
  String value() {
    switch (this) {
      case DateTimeFormatType.fullDate:
        return 'dd/MM/yyyy';
    }
  }
}

extension DateTimeExtension on DateTime {

  String toStringWith({format: String}) {
    String formattedDate = DateFormat(format).format(this);
    return formattedDate;
  }

  String toStringWithType({DateTimeFormatType type}) {
    String formattedDate = DateFormat(type.value()).format(this);
    return formattedDate;
  }

}