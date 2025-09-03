import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';

class ViewFoodWithNutrients extends StatelessWidget {
  final CompleteFood food;

  const ViewFoodWithNutrients({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomContainer(
        isGradient: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Opis główny
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

              // Informacje podstawowe
              Text(
                "Basic information",
                style: AppTextStyles.subheading(context),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(context, "Food Class", food.foodClass),
              _buildInfoRow(context, "FDC ID", food.fdcId.toString()),

              const Divider(height: 24),

              // Składniki odżywcze
              Text("Nutrients", style: AppTextStyles.subheading(context)),
              const SizedBox(height: 8),
              ...food.nutrients.entries.map((entry) {
                final nutrient = entry.value;
                return _buildInfoRow(
                  context,
                  "${nutrient.nutrientName} (rank: ${nutrient.indexRanking})",
                  "${nutrient.value.toStringAsFixed(2)} ${nutrient.unit}",
                );
              }).toList(),
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
