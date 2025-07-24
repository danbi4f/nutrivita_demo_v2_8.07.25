import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/cut_survey_foods/data/model/cut_survey_model.dart';

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
    return Card(
      color: Theme.of(context).colorScheme.surfaceBright,
      margin: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(5),
        ),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              item.descriptionPL,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
