class FoodItem {
  final String name;
  final String quantity;
  final int calories;
  final String? details;

  FoodItem({
    required this.name,
    required this.quantity,
    required this.calories,
    this.details,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    final nutriments = json['nutriments'] ?? {};
    return FoodItem(
      name: json['product_name'] ?? 'Unnamed Food',
      quantity: json['quantity'] ?? 'N/A',
      calories: (nutriments['energy-kcal'] ?? 0).toInt(),
      details: json['ingredients_text'] ?? '',
    );
  }
}
