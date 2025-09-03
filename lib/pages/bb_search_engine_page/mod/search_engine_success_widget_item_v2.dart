import 'package:flutter/material.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_description.dart';

class SearchEngineSuccessWidgetItemV2 extends StatelessWidget {
  const SearchEngineSuccessWidgetItemV2({super.key, required this.food});

  final SurveyFoodsDescription food;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 8.0,
          left: 8.0,
          top: 8.0,
          bottom: 8.0,
        ),
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
                    food.descriptionPL,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading(context),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    food.description,
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
                    // final bloc = context.read<FavoriteFoodsBloc>();
                    // if (isFavorite) {
                    //   bloc.add(RemoveFavoriteFood(item.fdcId));
                    // } else {
                    //   bloc.add(
                    //     AddFavoriteFood(
                    //       item.copyWith(
                    //         indexRanking: index,
                    //         rankingName: nameRanking,
                    //       ),
                    //     ),
                    //   );
                    // }
                  },
                  icon: Icon(
                    // isFavorite ?
                    Icons.favorite,
                    // : Icons.favorite_border,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
