import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/arc/survey_foods.dart';

class ViewSurveyFoods extends StatelessWidget {
  final SurveyFoods food;

  const ViewSurveyFoods({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    final nutrientsList =
        food.nutrients.entries.map((entry) {
          final nutrientKey = entry.key;
          final value = entry.value;
          final name = food.nameNutrient[nutrientKey] ?? nutrientKey;
          final unit = food.unitNameNutrient[nutrientKey] ?? '';
          return {'name': name, 'value': value, 'unit': unit};
        }).toList();

    return Scaffold(
      appBar: AppBar(),
      body: CustomContainer(
        isGradient: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      food.description,
                      style: AppTextStyles.heading(context),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('100 g', style: AppTextStyles.body(context)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                food.descriptionPL,
                style: AppTextStyles.body(context, size: 20),
              ),
              const Divider(height: 24),

              Text(
                "Basic information",
                style: AppTextStyles.subheading(context),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(context, "Food Class", food.foodClass),
              _buildInfoRow(context, "FDC ID", food.fdcId.toString()),
              if (food.id != null)
                _buildInfoRow(context, "Local DB ID", food.id.toString()),

              const Divider(height: 24),

              // Składniki odżywcze
              Text("Nutrients", style: AppTextStyles.subheading(context)),
              const SizedBox(height: 8),
              ...nutrientsList.map((nutrient) {
                return _buildInfoRow(
                  context,
                  nutrient['name'] as String,
                  "${(nutrient['value'] as double).toStringAsFixed(2)} ${nutrient['unit']}",
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body(context, isBold: true)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.body(context),
            ),
          ),
        ],
      ),
    );
  }
}
