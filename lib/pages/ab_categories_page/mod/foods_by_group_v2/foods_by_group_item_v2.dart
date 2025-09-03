import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/complet_foods/complet_foods.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_by_category/mod/top_food.dart';

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
    final DelayedResult<List<CompleteFood>> favoritesState =
        context.watch<FavoriteFoodsV2Bloc>().state.favorites;

    final List<CompleteFood> favoritesList = favoritesState.valueOrNull ?? [];

    final bool isFavorite = false;

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

                /// Tekst (zajmuje całą dostępną przestrzeń oprócz miejsca na ikonę)
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

                /// Ikona (stała szerokość -> wszystkie ikony w jednej linii)
                SizedBox(
                  width: 60, // możesz dostosować szerokość
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        final bloc = context.read<FavoriteFoodsV2Bloc>();
                        if (isFavorite) {
                          bloc.add(
                            RemoveFavoriteFoodFdcId(topFoodsByGroup.fdcId),
                          );
                        } else {
                          bloc.add(AddFavoriteFoodFdcId(topFoodsByGroup.fdcId));
                          print('Added to favorites');
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
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

          /// Nutrient info
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
                Spacer(),
                Text(
                  '${topFoodsByGroup.rankingName}    '
                  '${topFoodsByGroup.nutrientValue.toStringAsFixed(2)} '
                  '$unit',
                  style: AppTextStyles.body(context, isBold: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
