import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/domain/model/survey_foods_by_category/mod/top_food.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/presentation/bloc/complete_food_bloc.dart';
import 'package:nutrivita_demo_v2/pages/b_food/presentation/bloc/cubit/is_fave_bloc.dart';
import 'package:nutrivita_demo_v2/shared/services/combined_data_service.dart';

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
      create:
          (_) =>
              CompleteFoodBloc(combinedDataService: context.read())
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
  final foodState = context.select((CompleteFoodBloc bloc) => bloc.state.completeFood);

  if (foodState.isInProgress) {
    return const Center(child: CircularProgressIndicator());
  }

  if (foodState.isError) {
    return const Text("Błąd wczytywania produktu");
  }

  final food = foodState.value;
  if (food == null) {
    return const Text("Brak danych o produkcie");
  }

  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewFoodWithNutrients(food: food),
        ),
      );
    },
    child: _CompleteFoodItem.withBloc(
      topFoodsByGroup,
      unit,
      food,
    ),
  );
}

}

class _CompleteFoodItem extends StatefulWidget {
  const _CompleteFoodItem({
    required this.food,
    required this.topFoodsByGroup,
    required this.unit,
  });
  final CompleteFood food;
  final TopFood topFoodsByGroup;
  final String unit;

  static Widget withBloc(TopFood top, String unit, CompleteFood food) {
    return BlocProvider(
      create:
          (context) =>
              IsFaveBloc(context.read<CombinedDataService>(), food: food)
                ..add(LoadIsFave()),
      child: _CompleteFoodItem(food: food, topFoodsByGroup: top, unit: unit),
    );
  }

  @override
  State<_CompleteFoodItem> createState() => _CompleteFoodItemState();
}

class _CompleteFoodItemState extends State<_CompleteFoodItem> {
  late final IsFaveBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<IsFaveBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsFaveBloc, IsFaveState>(
      builder: (context, state) {
        return CustomContainer(
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
                            widget.topFoodsByGroup.descriptionPL,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.subheading(context),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.topFoodsByGroup.description,
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
                            _toggleFavourite();
                          },
                          icon: Icon(
                            state.isFave
                                ? Icons.favorite
                                : Icons.favorite_border,
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
                        "${widget.topFoodsByGroup.indexRanking}",
                        style: AppTextStyles.body(context, isBold: true),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.topFoodsByGroup.rankingName}    '
                      '${widget.topFoodsByGroup.nutrientValue.toStringAsFixed(2)} '
                      '${widget.unit}',
                      style: AppTextStyles.body(context, isBold: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleFavourite() => _bloc.add(const ToggleFave());
}
