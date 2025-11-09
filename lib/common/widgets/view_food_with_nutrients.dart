import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/widgets/food_details_layout.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class ViewFoodWithNutrients extends StatelessWidget {
  final Food food;
  const ViewFoodWithNutrients({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return FoodDetailsLayout(
      description: food.description,
      descriptionPL: food.descriptionPL,
      foodClass: food.foodClass,
      fdcId: food.fdcId.toString(),
      nutrients:
          food.nutrients.entries.map((entry) {
            final nutrient = entry.value;
            return MapEntry(
              "${nutrient.nutrientName} (${t.details_food.rank}: ${nutrient.indexRanking})",
              "${nutrient.value.toStringAsFixed(2)} ${nutrient.unit}",
            );
          }).toList(),
    );
  }
}
