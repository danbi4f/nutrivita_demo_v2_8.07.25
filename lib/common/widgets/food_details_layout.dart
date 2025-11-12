import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/widgets/build_info_row.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class FoodDetailsLayout extends StatelessWidget {
  final String description;
  final String descriptionPL;
  final String foodClass;
  final String fdcId;
  final List<MapEntry<String, String>> nutrients;

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
    final t = Translations.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          t.details_food.food_details,
          style: AppTextStyles.heading(context, size: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
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
                      description,
                      style: AppTextStyles.heading(context),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    t.details_food.k100G,
                    style: AppTextStyles.body(context),
                  ),
                ],
              ),
              const Divider(height: 24),

              Text(
                t.details_food.basic_information,
                style: AppTextStyles.subheading(context),
              ),
              const SizedBox(height: 8),
              BuildInfoRow(
                context: context,
                label: t.details_food.food_class,
                value: foodClass,
              ),
              BuildInfoRow(
                context: context,
                label: t.details_food.fdc_id,
                value: fdcId,
              ),

              const Divider(height: 24),

              Text(
                t.details_food.nutrients,
                style: AppTextStyles.subheading(context),
              ),
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
