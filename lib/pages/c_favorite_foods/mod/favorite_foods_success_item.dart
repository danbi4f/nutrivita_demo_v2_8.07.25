import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_survey_foods.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/c_favorite_foods/bloc/favorite_foods_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';

class FavoriteFoodsSuccessItem extends StatelessWidget {
  const FavoriteFoodsSuccessItem({super.key, required this.food});

  final SurveyFoods food;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(food.fdcId.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        context.read<FavoriteFoodsBloc>().add(RemoveFavoriteFood(food.fdcId));
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
              builder: (context) => ViewSurveyFoods(food: food),
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
                        food.descriptionPL,
                        style: AppTextStyles.subheading(context),
                        softWrap: true,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        food.description,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.body(context),
                        softWrap: true,
                      ),
                      if (food.indexRanking != null && food.rankingName != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${food.rankingName} |",
                                style: AppTextStyles.body(context),
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "Ranking: ${(food.indexRanking! + 1)}",
                              style: AppTextStyles.body(context),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
