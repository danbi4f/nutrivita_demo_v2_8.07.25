import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widget/card_container.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/category_group/data/model/category_group.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/mod/select_number/select_number.dart';

class CategoryGroupItem extends StatelessWidget {
  const CategoryGroupItem({
    super.key,
    required this.category,
    required this.flag,
  });

  final CategoryGroup category;
  final bool flag;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectNumber(category: category, flag: flag),
        ),
      );
    }

    return CardContainer(
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
