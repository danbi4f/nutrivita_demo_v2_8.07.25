import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/mod/search_engine_success_widget_item_v2.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_description.dart';

class SearchEngineSuccessWidgetV2 extends StatelessWidget {
  const SearchEngineSuccessWidgetV2({super.key, required this.results});

  final List<SurveyFoodsDescription> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          "Type something to start searching.",
          style: AppTextStyles.subheading(context, isBold: true),
        ),
      );
    }

    return ListView.builder(
  itemCount: foods.length,
  itemBuilder: (context, index) {
    final food = foods[index];
    return SearchEngineSuccessWidgetItemV2(
      key: ValueKey(food.fdcId), // 🔑 KLUCZ unikalny
      food: food,
    );
  },
)
}
