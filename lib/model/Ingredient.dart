class Ingredient {
  final String unit;
  final String ingredientName;
  final double quantity;

  const Ingredient({
    required this.unit,
    required this.ingredientName,
    required this.quantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      unit: json['unit'],
      ingredientName: json['ingredient_name'],
      quantity: json['quantity'].toDouble(),
    );
  }
}