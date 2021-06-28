import 'package:money2/money2.dart';

class CustomMoneyFormatter {
  static String Function(int) formatMoney = (amount) {
    final toman = Currency.create('تومان', 0, pattern: '###,### S', symbol: 'تومان');
    final money = Money.fromInt(amount, toman);
    return money.toString();
  };
}
