import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/cut_survey_foods/data/model/cut_survey_model.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // dark
          BoxShadow(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            offset: const Offset(7, 7),
            blurRadius: 25,
            spreadRadius: 2,
          ),

          // light
          BoxShadow(
            color: Colors.white.withOpacity(0.4),
            offset: const Offset(-4, -4),
            blurRadius: 20,
            spreadRadius: 0,
          ),

          //
        ],
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: Column(
          children: [
            Text(
              item.descriptionPL,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
            ),
            SizedBox(height: 10),
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.surfaceBright,
              ),
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
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surfaceBright,
                    ),
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
