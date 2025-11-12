import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/number_group/number_group_item.dart';
import 'package:nutrivita_demo_v2/common/widgets/paged_grid_layout.dart';

class NumberGroup extends StatelessWidget {
  final CategoryNutrient item;

  const NumberGroup({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: PagedGridLayout(
            items: item.nutrients,
            itemsPerPage: 6,
            columns: 2,
            itemBuilder: (nutrient) => NumberGroupItem(nutrientByGroup: nutrient),
          ),
        ),
      ),
    );
  }
}
