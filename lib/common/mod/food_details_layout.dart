import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/build_info_row.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';

class FoodDetailsLayout extends StatelessWidget {
  final String description;
  final String descriptionPL;
  final String foodClass;
  final String fdcId;
  final List<MapEntry<String, String>> nutrients; // lista klucz:wartość

  const FoodDetailsLayout({
    super.key,
    required this.description,
    required this.descriptionPL,
    required this.foodClass,
    required this.fdcId,
    required this.nutrients,
  });

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
                      description,
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
              Text(descriptionPL, style: AppTextStyles.body(context, size: 20)),
              const Divider(height: 24),

              // Informacje podstawowe
              Text(
                "Basic information",
                style: AppTextStyles.subheading(context),
              ),
              const SizedBox(height: 8),
              BuildInfoRow(
                context: context,
                label: "Food Class",
                value: foodClass,
              ),
              BuildInfoRow(context: context, label: "FDC ID", value: fdcId),

              const Divider(height: 24),

              // Składniki odżywcze
              Text("Nutrients", style: AppTextStyles.subheading(context)),
              const SizedBox(height: 8),
              ...nutrients.map(
                (entry) => BuildInfoRow(
                  context: context,
                  label: entry.key,
                  value: entry.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
