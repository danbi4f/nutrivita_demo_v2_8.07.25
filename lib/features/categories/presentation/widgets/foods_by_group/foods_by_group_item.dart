import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/top_food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/is_fave_bloc.dart';

class FoodsByGroupItem extends StatefulWidget {
  const FoodsByGroupItem({
    super.key,
    required this.topFoodsByGroup,
    required this.unit,
    required this.food,
  });

  final TopFood topFoodsByGroup;
  final String unit;
  final Food food;

  @override
  State<FoodsByGroupItem> createState() => _FoodsByGroupItemState();
}

class _FoodsByGroupItemState extends State<FoodsByGroupItem> {


  @override
  Widget build(BuildContext context) {
    return _FoodsByGroupItemView(
      topFoodsByGroup: widget.topFoodsByGroup,
      unit: widget.unit,
      food: widget.food,
    );
  }
}

class _FoodsByGroupItemView extends StatelessWidget {
  const _FoodsByGroupItemView({
    required this.topFoodsByGroup,
    required this.unit,
    required this.food,
  });

  final TopFood topFoodsByGroup;
  final String unit;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IsFaveBloc, IsFaveState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewFoodWithNutrients(food: food),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFD9E5C4),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
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
                  Text(
                    topFoodsByGroup.description,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading(context),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.ads_click_rounded, color: Colors.grey),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed:
                                () => context.read<IsFaveBloc>().add(
                                  ToggleFavorite(food.fdcId),
                                ),
                            icon: Icon(
                              context.select<IsFaveBloc, bool>(
                                    (b) => b.state.faveIds.contains(food.fdcId),
                                  )
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white,
                              child: Text(
                                "${topFoodsByGroup.indexRanking}",
                                style: AppTextStyles.body(
                                  context,
                                  isBold: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                topFoodsByGroup.rankingName.length > 10
                                    ? '${topFoodsByGroup.rankingName.substring(0, 10)}…'
                                    : topFoodsByGroup.rankingName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppTextStyles.body(
                                  context,
                                  isBold: true,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${topFoodsByGroup.nutrientValue.toStringAsFixed(2)} $unit',
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
          ),
        );
      },
    );
  }
}


