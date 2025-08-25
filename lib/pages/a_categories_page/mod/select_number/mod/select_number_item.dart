import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group_nutrient_number.dart';

class SelectNumberItem extends StatelessWidget {
  final CategoryGroupNutrientNumber nutrientByGroup;
  final ValueChanged<String> onTapItem; // callback

  const SelectNumberItem({
    super.key,
    required this.nutrientByGroup,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapItem(nutrientByGroup.number),
      child: CustomContainer(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              nutrientByGroup.name,
              style: AppTextStyles.subheading(context),
            ),
            Text(
              nutrientByGroup.number,
              style: AppTextStyles.subheading(context),
            ),
          ],
        ),
      ),
    );
  }
}
