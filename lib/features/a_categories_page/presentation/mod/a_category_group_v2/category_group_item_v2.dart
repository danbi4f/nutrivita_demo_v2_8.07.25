import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/presentation/mod/b_number_group_v2/number_group_v2.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/survey_foods_by_category.dart';

class CategoryGroupItemV2 extends StatelessWidget {
  const CategoryGroupItemV2({super.key, required this.item});
  final SurveyFoodsByCategory item;

  @override
  Widget build(BuildContext context) {
    void onTap() {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NumberGroupV2(item: item)),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12), 
        onTap: onTap,
        child: CustomContainer(
          child: Center(
            child: Text(item.category, style: AppTextStyles.heading(context)),
          ),
        ),
      ),
    );
  }
}
