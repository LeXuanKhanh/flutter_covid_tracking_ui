import 'package:intl/intl.dart';

extension IntExtension on int {

  String toStringWithFormat() {
    final formatter = NumberFormat("#.###");
    return NumberFormat.decimalPattern().format(this);
    
  }

}