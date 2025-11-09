import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/category_nutrient.dart';
import 'package:nutrivita_demo_v2/features/categories/presentation/widgets/category_group/category_group_item.dart';
import 'package:nutrivita_demo_v2/i18n/strings.g.dart';

class CategoryGroupSuccessWidget extends StatelessWidget {
  final List<CategoryNutrient> categories;

  const CategoryGroupSuccessWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    if (categories.isEmpty) {
      return  Center(child: Text(t.alerts.no_data));
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
