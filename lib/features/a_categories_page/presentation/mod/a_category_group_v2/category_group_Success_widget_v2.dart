import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/presentation/mod/a_category_group_v2/category_group_item_v2.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';

class CategoryGroupSuccessWidgetV2 extends StatelessWidget {
  final List<SurveyFoodsByCategory> categories;

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
