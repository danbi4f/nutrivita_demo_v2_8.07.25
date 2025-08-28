import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/pages/c_favorite_foods/bloc/favorite_foods_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods.dart';

class SearchEngineItem extends StatelessWidget {
  const SearchEngineItem({super.key, required this.item});

  final SurveyFoods item;

  @override
  Widget build(BuildContext context) {
    final favoritesState = context.watch<FavoriteFoodsBloc>().state.favorites;
    final favoritesList = favoritesState.valueOrNull ?? [];
    final isFavorite = favoritesList.any((food) => food.fdcId == item.fdcId);
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        item.descriptionPL,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subheading(context),
                      ),
                      SizedBox(height: 10),
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body(context),
                      ),
                    ],
                  ),
                ),
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
                          bloc.add(AddFavoriteFood(item));
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
          ],
        ),
      ),
    );
  }
}
