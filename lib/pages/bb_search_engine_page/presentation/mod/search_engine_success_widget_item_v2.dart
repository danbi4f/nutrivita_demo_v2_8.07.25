import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/presentation/bloc/complete_food_bloc.dart';
import 'package:nutrivita_demo_v2/pages/bb_search_engine_page/domain/model/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';

class SearchEngineSuccessWidgetItemV2 extends StatelessWidget {
  const SearchEngineSuccessWidgetItemV2({
    super.key,
    required this.foodDescription,
  });

  final SurveyFoodsDescription foodDescription;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteFoodBloc(combinedDataService: context.read())
        ..add(LoadCompleteFoodByFdcId(foodDescription.fdcId)),
      child: _SearchEngineSuccessWidgetItemV2(
        foodDescription: foodDescription,
        isFavorite: false,
      ),
    );
  }
}

class _SearchEngineSuccessWidgetItemV2 extends StatelessWidget {
  const _SearchEngineSuccessWidgetItemV2({
    required this.foodDescription,
    bool? isFavorite,
  }) : _isFavorite = isFavorite ?? false;

  final SurveyFoodsDescription foodDescription;
  final bool? _isFavorite;


  @override
  Widget build(BuildContext context) {
        final item = context.select(
      (CompleteFoodBloc bloc) => bloc.state.completeFood,
    );
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewFoodWithNutrients(food: item.value!),
          ),
        );
      },
      child: CustomContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.ads_click_rounded, color: Colors.grey),
              const SizedBox(width: 10),

              /// Teksty
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      foodDescription.descriptionPL,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheading(context),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      foodDescription.description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(context),
                    ),
                    Text(
                      foodDescription.fdcId.toString(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body(context),
                    ),
                  ],
                ),
              ),

              /// Ikona serca
              SizedBox(
                width: 60,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      _isFavorite! ? Icons.favorite : Icons.favorite_border,
                      color: Colors.green,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
