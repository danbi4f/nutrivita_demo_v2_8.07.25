import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/arc/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/pages/home/home_page.dart';

class CategoryGroupItem extends StatelessWidget {
  const CategoryGroupItem({super.key, required this.category});
  final CategoryGroup category;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      final homeState = context.findAncestorStateOfType<HomePageState>();
      homeState?.openSelectNumber(category);
    }

    return Material(
      // ważne – daje powierzchnię pod InkWell
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12), // opcjonalnie zaokrąglone rogi
        onTap: onTap,
        child: CustomContainer(
          child: Center(
            child: Text(
              category.categoryName,
              style: AppTextStyles.heading(context),
            ),
          ),
        ),
      ),
    );
  }
}
