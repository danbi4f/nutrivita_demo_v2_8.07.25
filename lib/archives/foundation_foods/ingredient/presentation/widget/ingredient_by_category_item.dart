import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widget/card_container.dart';
import 'package:nutrivita_demo_v2/archives/foundation_foods/ingredient/data/model/food_nutrient_model.dart';
import 'package:nutrivita_demo_v2/archives/foundation_foods/ingredient/data/model/nutrient_model.dart';
import 'package:nutrivita_demo_v2/archives/foundation_foods/ingredient/domain/entities/food_entity.dart';
import 'package:nutrivita_demo_v2/archives/foundation_foods/ingredient/presentation/widget/ingredient_by_category_EN.dart';

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
    return CardContainer(
      child: Column(
        children: [
          SelectableText(
            item.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.subheading(context),
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
                  style: AppTextStyles.body(context),
                ),
                SizedBox(width: 10),
                Text(
                  '${nutrient.amount} ${nutrient.nutrient.unitName}',
                  style: AppTextStyles.body(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
