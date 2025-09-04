import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_description.dart';

class SearchEngineSuccessWidgetItemV2 extends StatefulWidget {
  const SearchEngineSuccessWidgetItemV2({super.key, required this.food});

  final SurveyFoodsDescription food;

  @override
  State<SearchEngineSuccessWidgetItemV2> createState() =>
      _SearchEngineSuccessWidgetItemV2State();
}

class _SearchEngineSuccessWidgetItemV2State
    extends State<SearchEngineSuccessWidgetItemV2> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    final favoritesState = context.read<FavoriteFoodsV2Bloc>().state.favorites;
    final favoritesList = favoritesState.valueOrNull ?? [];

    /// LOG: zawartość favoritesList
    print('[DEBUG] Favorites list length: ${favoritesList.length}');
    for (final f in favoritesList) {
      print('[DEBUG] Favorite item fdcId: ${f.fdcId}');
    }

    /// LOG: sprawdzamy aktualny element
    print('[DEBUG] Checking widget.food fdcId: ${widget.food.fdcId}');
    print(
      '[DEBUG] Checking widget.food => fdcId: ${widget.food.fdcId}, '
      'descriptionPL: ${widget.food.descriptionPL}',
    );

    _isFavorite = favoritesList.any((food) => food.fdcId == widget.food.fdcId);

    print('[DEBUG] Initial _isFavorite = $_isFavorite');
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.ads_click_rounded, color: Colors.grey),
            const SizedBox(width: 10),

            /// Teksty
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.food.descriptionPL,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading(context),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.food.description,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(context),
                  ),
                  Text(
                    '${widget.food.descriptionPL} (${widget.food.fdcId})',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(context),
                  ),
                ],
              ),
            ),

            /// Ikona serca
            SizedBox(
              width: 60,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    final bloc = context.read<FavoriteFoodsV2Bloc>();

                    print(
                      '[DEBUG] IconButton pressed for fdcId: ${widget.food.fdcId} | current _isFavorite=$_isFavorite',
                    );

                    setState(() {
                      _isFavorite = !_isFavorite;
                    });

                    if (_isFavorite) {
                      print(
                        '[DEBUG] Adding to favorites: ${widget.food.fdcId}',
                      );
                      bloc.add(AddFavoriteFoodFdcId(widget.food.fdcId));
                    } else {
                      print(
                        '[DEBUG] Removing from favorites: ${widget.food.fdcId}',
                      );
                      bloc.add(RemoveFavoriteFoodFdcId(widget.food.fdcId));
                    }
                  },
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
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
