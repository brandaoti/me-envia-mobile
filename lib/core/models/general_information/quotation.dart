import 'package:intl/intl.dart';

class Quotation {
  final String id;
  final double money;

  const Quotation({
    required this.id,
    required this.money,
  });

  factory Quotation.fromJson(Map json) {
    final dollarText = (json['text'] as String).replaceAll(',', '.');
    return Quotation(
      id: json['id'],
      money: double.parse(dollarText),
    );
  }

  Map toMap() {
    return {
      'id': id,
      'text': money.toString(),
    };
  }

  String get formattedDollarMoney {
    return NumberFormat.currency(
      symbol: 'U\$',
      locale: 'pt_BR',
    ).format(money);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Quotation && other.id == id && other.money == money;
  }

  @override
  int get hashCode => id.hashCode ^ money.hashCode;

  @override
  String toString() => 'Quotation(id: $id, money: $money)';
}
