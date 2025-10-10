import 'dart:convert';

import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/complet_foods.dart';

class Meal {
  final int? id;
  final String name;
  final List<CompleteFood> foods;

  Meal({this.id, required this.name, required this.foods});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'foods': jsonEncode(foods.map((x) => x.toMap()).toList()),
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      name: map['name'],
      foods:
          (jsonDecode(map['foods']) as List)
              .map((x) => CompleteFood.fromMap(x))
              .toList(),
    );
  }
}

extension MealNutrientSum on Meal {
  double sumNutrient(String nutrientNumber) {
    double total = 0.0;
    for (final food in foods) {
      final nutrient = food.nutrients[nutrientNumber];
      if (nutrient != null) {
        total += nutrient.value; // ✅ teraz działa
      }
    }
    return total;
  }

  Map<String, double> sumAllNutrients() {
    final Map<String, double> totals = {};
    for (final food in foods) {
      for (final entry in food.nutrients.entries) {
        totals.update(
          entry.key,
          (value) => value + entry.value.value,
          ifAbsent: () => entry.value.value,
        );
      }
    }
    return totals;
  }
}
