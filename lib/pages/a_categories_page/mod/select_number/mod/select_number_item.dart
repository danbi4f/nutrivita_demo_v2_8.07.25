import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widget/card_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group_nutrient_number.dart';
import 'package:nutrivita_demo_v2/archives/cut_survey_foods/presentation/widget/cut_survey_by_category_widget.dart';
import 'package:nutrivita_demo_v2/archives/foundation_foods/ingredient/presentation/widget/ingredient_by_category_widget.dart';

class SelectNumberItem extends StatelessWidget {
  const SelectNumberItem({
    super.key,
    required this.flag,
    required this.nutrientByGroup,
  });

  final bool flag;
  final CategoryGroupNutrientNumber nutrientByGroup;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) =>
                    flag
                        ? IngredientByCategoryWidget(
                          nutrientNumber: nutrientByGroup.number,
                        )
                        : CutSurveyByCategoryWidget(
                          nutrientNumber: nutrientByGroup.number,
                        ),
          ),
        );
      },
      child: CardContainer(
        child: Column(
          children: [
            SizedBox(height: 10),
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
