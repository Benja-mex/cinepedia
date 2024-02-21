import 'package:intl/intl.dart';

extension Converter on double {
  String toHumanFormat() {
    final formateddNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: "en_us",
    ).format(this);
    return formateddNumber;
  }
}
