import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/top_food.dart';

class FoodsByGroupItemV2 extends StatelessWidget {
  const FoodsByGroupItemV2({
    super.key,
    required this.topFoodsByGroup,
    required this.unit,
  });

  final TopFood topFoodsByGroup;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orangeAccent,
          child: Text(
            "${topFoodsByGroup.indexRanking}",
            style: AppTextStyles.body(context, isBold: true),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topFoodsByGroup.descriptionPL,
              style: AppTextStyles.body(context, isBold: true),
            ),
            Text(
              topFoodsByGroup.description,
              style: AppTextStyles.body(context),
            ),
          ],
        ),
        trailing: Text(
          "${topFoodsByGroup.nutrientValue.toStringAsFixed(1)} $unit",
          style: AppTextStyles.body(context, isBold: true),
        ),
      ),
    );
  }
}
