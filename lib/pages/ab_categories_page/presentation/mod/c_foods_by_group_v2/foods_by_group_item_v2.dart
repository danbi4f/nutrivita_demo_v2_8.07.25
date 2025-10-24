import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/survey_foods_by_category/mod/top_food.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/bloc/complete_food_bloc.dart';

class FoodsByGroupItemV2 extends StatelessWidget {
  const FoodsByGroupItemV2({
    super.key,
    required this.topFoodsByGroup,
    required this.unit,
  });

  final TopFood topFoodsByGroup;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteFoodBloc(combinedDataService: context.read())
        ..add(LoadCompleteFoodByFdcId(topFoodsByGroup.fdcId)),
      child: _FoodsByGroupItemView(
        topFoodsByGroup: topFoodsByGroup,
        unit: unit,
      ),
    );
  }
}


class _FoodsByGroupItemView extends StatelessWidget {
  const _FoodsByGroupItemView({
    required this.topFoodsByGroup,
    required this.unit,
  });

  final TopFood topFoodsByGroup;
  final String unit;

  @override
  Widget build(BuildContext context) {
    //final _isFavorite = false;
    final item = context.select(
      (CompleteFoodBloc bloc) => bloc.state.completeFood,
    );

    return InkWell(
      onTap: () {
        if (item.value != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewFoodWithNutrients(food: item.value!),
            ),
          );
        }
      },
      child: CustomContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.ads_click_rounded, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          topFoodsByGroup.descriptionPL,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subheading(context),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          topFoodsByGroup.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          
                        },
                        icon: Icon(Icons.favorite_border,
                          //_isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[300],
                    child: Text(
                      "${topFoodsByGroup.indexRanking}",
                      style: AppTextStyles.body(context, isBold: true),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${topFoodsByGroup.rankingName}    '
                    '${topFoodsByGroup.nutrientValue.toStringAsFixed(2)} '
                    '${unit}',
                    style: AppTextStyles.body(context, isBold: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
