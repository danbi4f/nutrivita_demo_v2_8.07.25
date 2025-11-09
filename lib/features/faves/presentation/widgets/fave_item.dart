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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewFoodWithNutrients(food: food),
          ),
        );
      },
      child: SizedBox(
        height: 80,
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.body(context),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(width: 10),
                /// Delete icon
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<FaveBloc>().add(RemoveFave(fdcId));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
