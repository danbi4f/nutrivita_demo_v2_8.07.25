import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';

class CutSurveyByCategoryItem extends StatelessWidget {
  const CutSurveyByCategoryItem({
    super.key,
    required this.item,
    required this.nutrientNumber,
  });

  final SurveyFoods item;
  final String nutrientNumber;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Tekst (zajmuje całą dostępną przestrzeń oprócz miejsca na ikonę)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item.descriptionPL,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheading(context),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(context),
                    ),
                  ],
                ),
              ),

              /// Ikona (stała szerokość -> wszystkie ikony w jednej linii)
              SizedBox(
                width: 60, // możesz dostosować szerokość
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[300],
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Nutrient info
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${item.nameNutrient[nutrientNumber]} '
                  '${item.nutrients[nutrientNumber]?.toStringAsFixed(2)} '
                  '${item.unitNameNutrient[nutrientNumber]}',
                  style: AppTextStyles.body(context, isBold: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
