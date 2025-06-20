class FoodDataRoot {
  final List<FoundationFood> foundationFoods;

  FoodDataRoot({required this.foundationFoods});

  factory FoodDataRoot.fromJson(Map<String, dynamic> json) {
    return FoodDataRoot(
      foundationFoods:
          (json['FoundationFoods'] as List)
              .map((e) => FoundationFood.fromJson(e))
              .toList(),
    );
  }
}

class FoundationFood {
  final String description;
  final List<FoodNutrient> foodNutrients;

  FoundationFood({required this.description, required this.foodNutrients});

  factory FoundationFood.fromJson(Map<String, dynamic> json) {
    return FoundationFood(
      description: json['description'],
      foodNutrients:
          (json['foodNutrients'] as List)
              .map((e) => FoodNutrient.fromJson(e))
              .toList(),
    );
  }
}

class FoodNutrient {
  final double amount;
  final Nutrient nutrient;

  FoodNutrient({required this.amount, required this.nutrient});

  factory FoodNutrient.fromJson(Map<String, dynamic> json) {
    return FoodNutrient(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      nutrient: Nutrient.fromJson(json['nutrient']),
    );
  }
}

class Nutrient {
  final String number;
  final String name;
  final String unitName;

  Nutrient({required this.number, required this.name, required this.unitName});

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      number: json['number'],
      name: json['name'],
      unitName: json['unitName'],
    );
  }
}
