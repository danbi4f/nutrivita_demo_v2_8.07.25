import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/mod/b_number_group_v2/number_group_item_v2.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';

class NumberGroupV2 extends StatelessWidget {
  final SurveyFoodsByCategory item;

  const NumberGroupV2({required this.item, super.key});

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
          item.category,
          style: AppTextStyles.heading(context, size: 40),
        ),
        centerTitle: true,
      ),
      body: CustomContainer(
        isGradient: true,
        child: ListView.builder(
          itemCount: item.nutrients.length,
          itemBuilder: (context, index) {
            final nutrientsByGroup = item.nutrients[index];
            return NumberGroupItemV2(nutrientByGroup: nutrientsByGroup);
          },
        ),
      ),
    );
  }
}
