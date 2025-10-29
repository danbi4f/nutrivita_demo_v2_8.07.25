import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/presentation/mod/c_foods_by_group_v2/foods_by_group_v2.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/survey_foods_by_category/mod/nutrient_by_group.dart';

class NumberGroupItemV2 extends StatelessWidget {
  final NutrientByCategory nutrientByGroup;

  const NumberGroupItemV2({super.key, required this.nutrientByGroup});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => FoodsByGroupV2(nutrientByGroup: nutrientByGroup),
          ),
        );
      },
      child: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              nutrientByGroup.nutrientName,
              style: AppTextStyles.subheading(context),
              textAlign: TextAlign.center,
              softWrap: true, // wrap long names
            ),
            const SizedBox(height: 6),
            Text(
              nutrientByGroup.nutrientNumber,
              style: AppTextStyles.subheading(context),
            ),
          ],
        ),
      ),
    );
  }
}
