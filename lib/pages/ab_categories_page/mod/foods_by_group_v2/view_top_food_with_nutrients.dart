import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/food_details_layout.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/top_food.dart';

class ViewTopFoodWithNutrients extends StatelessWidget {
  final TopFood food;
  const ViewTopFoodWithNutrients({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return FoodDetailsLayout(
      description: food.description,
      descriptionPL: food.descriptionPL,
      foodClass: food.foodClass,
      fdcId: food.fdcId.toString(),
      nutrients: [
        MapEntry(food.rankingName, food.nutrientValue.toStringAsFixed(2)),
      ],
    );
  }
}
