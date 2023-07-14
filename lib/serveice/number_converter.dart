import 'package:numeral/numeral.dart';

class NumberFormatter {
  static String format({required num value}) {
    return Numeral(value).format();
  }
}
