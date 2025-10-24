import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/presentation/bloc/complete_food_bloc.dart';
import 'package:nutrivita_demo_v2/pages/c_fave/presentation/bloc/fave_bloc.dart';

class FaveItem extends StatelessWidget {
  const FaveItem({super.key, required this.fdcId});

  final int fdcId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              CompleteFoodBloc(combinedDataService: context.read())
                ..add(LoadCompleteFoodByFdcId(fdcId)),
      child: _FaveItem(fdcId),
    );
  }
}

class _FaveItem extends StatelessWidget {
  const _FaveItem(this.fdcId);

  final int fdcId;

  @override
  Widget build(BuildContext context) {
    final food = context.select(
      (CompleteFoodBloc bloc) => bloc.state.completeFood,
    );
    if (food.value == null) {
  return const CircularProgressIndicator(); 
}
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        context.read<FaveBloc>().add(RemoveFave(fdcId));
      },

      // Swipe od lewej do prawej (ikonka po lewej)
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      // Swipe od prawej do lewej (ikonka po prawej)
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
              builder: (context) => ViewFoodWithNutrients(food: food.value!),
            ),
          );
        },
        child: CustomContainer(
          child: ListTile(
            title: Row(
              children: [
                const Icon(Icons.ads_click_rounded, color: Colors.grey),
                const SizedBox(width: 10),

                /// Kolumna z opisem i rankingiem
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.value!.descriptionPL,
                        style: AppTextStyles.subheading(context),
                        softWrap: true,
                      ),
                      const SizedBox(height: 10),

                      Text(
                        food.value!.description,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.body(context),
                        softWrap: true,
                      ),
                      Text(
                        food.value!.fdcId.toString(),
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
