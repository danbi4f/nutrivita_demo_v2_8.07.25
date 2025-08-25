import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/select_number/select_number.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';

class CategoryGroupItem extends StatelessWidget {
  const CategoryGroupItem({super.key, required this.category});

  final CategoryGroup category;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      // Znajdujemy HomePageState i wywołujemy openSelectNumberPage
      final homeState = context.findAncestorStateOfType<HomePageState>();
      homeState?.openSelectNumber(category);
    }

    return CustomContainer(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Text(
            category.categoryName,
            //textAlign: TextAlign.center,
            style: AppTextStyles.heading(context),
          ),
        ),
      ),
    );
  }
}
