import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/categories/domain/entities/top_food.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';
import 'package:nutrivita_demo_v2/features/foods/presentation/bloc/is_fave_bloc.dart';

class FoodsByGroupItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocBuilder<IsFaveBloc, IsFaveState>(
      builder: (context, state) {
        final isFave = state.faveIds.contains(food.fdcId);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewFoodWithNutrients(food: food),
              ),
            );
          },
          child: CustomContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.ads_click_rounded,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Text(
                          "${topFoodsByGroup.indexRanking}",
                          style: AppTextStyles.body(context, isBold: true),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed:
                          () => context.read<IsFaveBloc>().add(
                            ToggleFavorite(food.fdcId),
                          ),
                      icon: Icon(
                        isFave ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red.shade200,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${topFoodsByGroup.nutrientValue.toStringAsFixed(2)} $unit',
                  style: AppTextStyles.body(context, isBold: true),
                ),
                const SizedBox(height: 15),
                Text(
                  topFoodsByGroup.description,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body(context, isBold: true),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
