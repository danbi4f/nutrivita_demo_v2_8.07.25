import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/complet_foods.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/domain/model/survey_foods_by_category/mod/top_food.dart';
import 'package:nutrivita_demo_v2/features/a_categories_page/presentation/bloc/complete_food_bloc.dart';
import 'package:nutrivita_demo_v2/features/b_food/presentation/bloc/cubit/is_fave_bloc.dart';
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
    final foodState = context.select(
      (CompleteFoodBloc bloc) => bloc.state.completeFood,
    );

    if (foodState.isInProgress) {
      return const Center(child: CircularProgressIndicator());
    }

    if (foodState.isError) {
      return const Text("Error loading product");
    }

    final food = foodState.value;
    if (food == null) {
      return const Text("No product data available");
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
      child: _CompleteFoodItem.withBloc(topFoodsByGroup, unit, food),
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9E5C4),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Opis
                Text(
                  widget.topFoodsByGroup.description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subheading(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),

                // Row with icons and values
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left part: icons
                    Row(
                      children: [
                        Icon(Icons.ads_click_rounded, color: Colors.grey),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: _toggleFavourite,
                          icon: Icon(
                            state.isFave
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    // Right part: ranking and values
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Text(
                              "${widget.topFoodsByGroup.indexRanking}",
                              style: AppTextStyles.body(context, isBold: true),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              widget.topFoodsByGroup.rankingName.length > 10
                                  ? '${widget.topFoodsByGroup.rankingName.substring(0, 10)}…'
                                  : widget.topFoodsByGroup.rankingName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: AppTextStyles.body(context, isBold: true),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${widget.topFoodsByGroup.nutrientValue.toStringAsFixed(2)} ${widget.unit}',
                            style: AppTextStyles.body(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleFavourite() => _bloc.add(const ToggleFave());
}
