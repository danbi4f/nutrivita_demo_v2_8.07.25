import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/data/model/food_nutrient_model.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/data/model/nutrient_model.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/domain/entities/food_entity.dart';
import 'package:nutrivita_demo_v2/foundation_foods/ingredient/presentation/widget/ingredient_by_category_EN.dart';

class IngredientByCategoryItem extends StatelessWidget {
  const IngredientByCategoryItem({
    super.key,
    required this.item,
    required this.nutrientNumber,
  });

  final FoodEntity item;
  final String nutrientNumber;

  @override
  Widget build(BuildContext context) {
    final nutrient = item.foodNutrients.firstWhere(
      (n) => n.nutrient.number == nutrientNumber,
      orElse:
          () => FoodNutrientModel(
            amount: 0,
            nutrient: NutrientModel(
              number: 'null',
              name: 'null',
              unitName: 'null',
            ),
          ),
    );

    return Card(
      color: Theme.of(context).colorScheme.surfaceBright,
      margin: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(5),
        ),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            IngredientByCategoryEn(item: item),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    nutrient.nutrient.name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${nutrient.amount} ${nutrient.nutrient.unitName}',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
