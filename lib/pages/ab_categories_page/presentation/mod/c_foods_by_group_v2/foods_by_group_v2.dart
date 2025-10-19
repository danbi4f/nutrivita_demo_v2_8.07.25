import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/mod/c_foods_by_group_v2/foods_by_group_item_v2.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/survey_foods_by_category/mod/nutrient_by_group.dart';

class FoodsByGroupV2 extends StatelessWidget {
  const FoodsByGroupV2({super.key, required this.nutrientByGroup});

  final NutrientByCategory nutrientByGroup;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        title: Text(
          nutrientByGroup.nutrientName,
          style: AppTextStyles.heading(context, size: 40),
        ),
        centerTitle: true,
      ),
      body: CustomContainer(
        isGradient: true,
        child: ListView.builder(
          itemCount: nutrientByGroup.topFoods.length,
          itemBuilder: (context, index) {
            final topFoodsByGroup = nutrientByGroup.topFoods[index];
            return FoodsByGroupItemV2(
              topFoodsByGroup: topFoodsByGroup,
              unit: nutrientByGroup.unit,
            );
          },
        ),
      ),
    );
  }
}
