typedef DeclarationList = List<Declaration>;

class Declaration {
  final String name;
  final String category;
  final String description;
  final int quantity;
  final double unitaryValue;
  final double totalValue;

  const Declaration({
    required this.name,
    required this.category,
    required this.description,
    required this.quantity,
    required this.unitaryValue,
    required this.totalValue,
  });

  factory Declaration.fromJson(Map json) {
    return Declaration(
      name: json['name'],
      quantity: json['quantity'],
      category: json['category'],
      totalValue: json['totalValue'],
      description: json['description'],
      unitaryValue: json['unitaryValue'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category,
      'totalValue': totalValue,
      'description': description,
      'unitaryValue': unitaryValue,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Declaration &&
        other.name == name &&
        other.category == category &&
        other.description == description &&
        other.quantity == quantity &&
        other.unitaryValue == unitaryValue &&
        other.totalValue == totalValue;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        category.hashCode ^
        description.hashCode ^
        quantity.hashCode ^
        unitaryValue.hashCode ^
        totalValue.hashCode;
  }

  @override
  String toString() {
    return 'Declaration(name: $name, category: $category, description: $description, quantity: $quantity, unitaryValue: $unitaryValue, totalValue: $totalValue)';
  }
}
