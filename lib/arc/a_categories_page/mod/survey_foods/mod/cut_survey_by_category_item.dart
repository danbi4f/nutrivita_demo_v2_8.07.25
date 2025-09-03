import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/view_survey_foods.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/arc/c_favorite_foods/bloc/favorite_foods_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/arc/survey_foods.dart';

class CutSurveyByCategoryItem extends StatelessWidget {
  const CutSurveyByCategoryItem({
    super.key,
    required this.item,
    required this.nutrientNumber,
    required this.index,
    required this.nameRanking,
  });

  final SurveyFoods item;
  final String nutrientNumber;
  final int index;
  final String nameRanking;

  @override
  Widget build(BuildContext context) {
    final favoritesState = context.watch<FavoriteFoodsBloc>().state.favorites;
    final favoritesList = favoritesState.valueOrNull ?? [];
    final isFavorite = favoritesList.any((food) => food.fdcId == item.fdcId);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewSurveyFoods(food: item)),
        );
      },
      child: CustomContainer(
        child: Column(
          children: [
            Row(
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
                        item.descriptionPL,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subheading(context),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.description,
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
                        final bloc = context.read<FavoriteFoodsBloc>();
                        if (isFavorite) {
                          bloc.add(RemoveFavoriteFood(item.fdcId));
                        } else {
                          bloc.add(
                            AddFavoriteFood(
                              item.copyWith(
                                indexRanking: index,
                                rankingName: nameRanking,
                              ),
                            ),
                          );
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

            const SizedBox(height: 20),

            /// Nutrient info
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${item.nameNutrient[nutrientNumber]} '
                    '${item.nutrients[nutrientNumber]?.toStringAsFixed(2)} '
                    '${item.unitNameNutrient[nutrientNumber]}',
                    style: AppTextStyles.body(context, isBold: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
