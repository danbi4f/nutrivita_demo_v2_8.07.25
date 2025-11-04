import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/widgets/custom_container.dart';
import 'package:nutrivita_demo_v2/common/widgets/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/config/fonts/app_text_style.dart';
import 'package:nutrivita_demo_v2/features/faves/presentation/bloc/fave_bloc.dart';
import 'package:nutrivita_demo_v2/features/foods/domain/entities/food.dart';

class FaveItem extends StatelessWidget {
  const FaveItem({super.key, required this.fdcId, required this.food});

  final int fdcId;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return _FaveItem(fdcId: fdcId, food: food);
  }
}

class _FaveItem extends StatelessWidget {
  const _FaveItem({required this.fdcId, required this.food});

  final int fdcId;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        context.read<FaveBloc>().add(RemoveFave(fdcId));
      },

      // Swipe from left to right (icon on the left)
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      // Swipe from right to left (icon on the right)
      secondaryBackground: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewFoodWithNutrients(food: food),
            ),
          );
        },
        child: CustomContainer(
          child: ListTile(
            title: Row(
              children: [
                const Icon(Icons.ads_click_rounded, color: Colors.grey),
                const SizedBox(width: 10),

                /// Description and ranking column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.description,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.body(context),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),
                Row(
                  children: const [
                    Icon(Icons.delete, color: Colors.grey),
                    Icon(Icons.play_arrow, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
