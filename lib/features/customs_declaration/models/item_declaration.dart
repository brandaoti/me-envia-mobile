import '../../../core/core.dart';

typedef ItemDeclarationList = List<ItemDeclaration>;

class ItemDeclaration {
  String? id;
  String? category;
  String? description;
  int? quantity;
  double? totalValue;
  double? unitaryValue;

  ItemDeclaration({
    this.id,
    this.category,
    this.description,
    this.quantity,
    this.totalValue,
    this.unitaryValue,
  });

  Declaration toDeclaration() {
    return Declaration(
      name: id ?? '',
      category: category ?? '',
      quantity: quantity ?? 0,
      totalValue: totalValue ?? 0.0,
      description: description ?? '',
      unitaryValue: unitaryValue ?? 0.0,
    );
  }

  ItemDeclaration copyWith({
    String? category,
    String? description,
    int? quantity,
    double? unitaryValue,
    double? totalValue,
  }) {
    return ItemDeclaration(
      id: id,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitaryValue: unitaryValue ?? this.unitaryValue,
      totalValue: totalValue ?? this.totalValue,
    );
  }

  String get formatterUnityValue {
    return unitaryValue?.formatterMoney ?? '';
  }

  String get formatterTotalValue {
    return totalValue?.formatterMoney ?? '';
  }

  void clean() {
    id = null;
    category = null;
    quantity = null;
    totalValue = null;
    description = null;
    unitaryValue = null;
  }

  @override
  String toString() {
    return 'DeclarationInformation(id:$id category: $category, description: $description, quantity: $quantity, unitaryValue: $unitaryValue, totalValue: $totalValue)';
  }
}
