import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/category_group/category_group_item.dart';

class CategoryGroupSuccessWidget extends StatelessWidget {
  final List<CategoryNutrient> categories;

  const CategoryGroupSuccessWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: Text("No categories to display"));
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
        return CategoryGroupItem(item: category);
      },
    );
  }
}
