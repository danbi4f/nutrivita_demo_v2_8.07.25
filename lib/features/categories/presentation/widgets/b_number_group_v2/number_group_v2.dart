import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/b_number_group_v2/number_group_item_v2.dart';

class NumberGroupV2 extends StatelessWidget {
  final CategoryNutrient item;

  const NumberGroupV2({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          item.category,
          style: AppTextStyles.heading(context, size: 40),
        ),
        centerTitle: true,
      ),
      body: CustomContainer(
        isGradient: true,
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,           // 2 columns
            crossAxisSpacing: 12,        // spacing between columns
            mainAxisSpacing: 12,         // spacing between rows
            childAspectRatio: 3 / 2,     // adjust height based on content
          ),
          itemCount: item.nutrients.length,
          itemBuilder: (context, index) {
            final nutrientsByGroup = item.nutrients[index];
            return NumberGroupItemV2(nutrientByGroup: nutrientsByGroup);
          },
        ),
      ),
    );
  }
}
