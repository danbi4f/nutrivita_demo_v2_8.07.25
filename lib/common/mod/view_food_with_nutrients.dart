import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/food_details_layout.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/complet_foods.dart';

class ViewFoodWithNutrients extends StatelessWidget {
  final CompleteFood food;
  const ViewFoodWithNutrients({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return FoodDetailsLayout(
      description: food.description,
      descriptionPL: food.descriptionPL,
      foodClass: food.foodClass,
      fdcId: food.fdcId.toString(),
      nutrients:
          food.nutrients.entries.map((entry) {
            final nutrient = entry.value;
            return MapEntry(
              "${nutrient.nutrientName} (rank: ${nutrient.indexRanking})",
              "${nutrient.value.toStringAsFixed(2)} ${nutrient.unit}",
            );
          }).toList(),
    );
  }
}
