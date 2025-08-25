import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/select_number/mod/select_number_item.dart';

class SelectNumber extends StatelessWidget {
  const SelectNumber({
    super.key,
    required this.category,
    required this.onSelectNutrient,
    required this.onBack,
  });

  final CategoryGroup category;
  final ValueChanged<String> onSelectNutrient;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isGradient: true,
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBack,
            ),
            backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            title: Text(
              category.categoryName,
              style: AppTextStyles.heading(context),
            ),
            centerTitle: true,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: category.nutrientsGroup.length,
              itemBuilder: (context, index) {
                final nutrientByGroup = category.nutrientsGroup[index];
                return GestureDetector(
                  onTap: () => onSelectNutrient(nutrientByGroup.number),
                  child: SelectNumberItem(nutrientByGroup: nutrientByGroup),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
