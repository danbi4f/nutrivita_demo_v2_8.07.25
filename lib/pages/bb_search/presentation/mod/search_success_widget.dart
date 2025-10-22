import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/bb_search/presentation/mod/search_item.dart';
import 'package:nutrivita_demo_v2/pages/bb_search/domain/model/survey_foods_description.dart';

class SearchSuccessWidget extends StatelessWidget {
  const SearchSuccessWidget({super.key, required this.results});

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

    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final food = results[index];
        print(
          '[DEBUG LIST] index=$index fdcId=${food.fdcId}, desc=${food.descriptionPL}',
        );
        return SearchItem(
          foodDescription: food,
          key: ValueKey(food.fdcId),
        );
      },
    );
  }
}
