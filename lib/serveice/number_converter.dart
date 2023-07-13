import 'package:numeral/numeral.dart';

class NumberFormatter {
  static String formatte({required int value}) {
    return Numeral(value).format();
  }
}
