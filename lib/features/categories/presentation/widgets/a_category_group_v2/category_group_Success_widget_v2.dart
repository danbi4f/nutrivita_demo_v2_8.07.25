import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/a_category_group_v2/category_group_item_v2.dart';

class CategoryGroupSuccessWidgetV2 extends StatelessWidget {
  final List<CategoryNutrient> categories;

  const CategoryGroupSuccessWidgetV2({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: Text("Brak kategorii do wyświetlenia"));
    }

    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 2 / 1,
      ),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryGroupItemV2(item: category);
      },
    );
  }
}
