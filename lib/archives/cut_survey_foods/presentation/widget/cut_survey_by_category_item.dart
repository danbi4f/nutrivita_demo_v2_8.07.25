import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widget/card_container.dart';
import 'package:nutrivita_demo_v2/archives/cut_survey_foods/data/model/cut_survey_model.dart';

class CutSurveyByCategoryItem extends StatelessWidget {
  const CutSurveyByCategoryItem({
    super.key,
    required this.item,
    required this.nutrientNumber,
  });

  final CutSurveyModel item;
  final String nutrientNumber;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          Text(
            item.descriptionPL,
            textAlign: TextAlign.center,
            style: AppTextStyles.subheading(context),
          ),
          SizedBox(height: 10),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.body(context),
          ),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 10),
                Text(
                  '${item.nameNutrients[nutrientNumber]} '
                  '${item.nutrients[nutrientNumber]?.toStringAsFixed(2)} '
                  '${item.unitNameNutrients[nutrientNumber]}',
                  style: AppTextStyles.subheading(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
