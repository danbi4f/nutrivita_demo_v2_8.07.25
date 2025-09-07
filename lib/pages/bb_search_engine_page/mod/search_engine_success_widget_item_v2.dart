import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/shared/models/survey_foods_description.dart';
import 'package:nutrivita_demo_v2/shared/repositories/complete_foods_repository.dart';

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

  void _updateFavoriteFlag() {
    final favoritesState = context.read<FavoriteFoodsV2Bloc>().state.favorites;
    final favoritesList = favoritesState.valueOrNull ?? [];

    setState(() {
      _isFavorite = favoritesList.any((f) => f.fdcId == widget.food.fdcId);
    });

    print(
      '[DEBUG] Updated _isFavorite=$_isFavorite for fdcId=${widget.food.fdcId}',
    );
  }

  @override
  void initState() {
    super.initState();
    _updateFavoriteFlag();
  }

  @override
  void didUpdateWidget(covariant SearchEngineSuccessWidgetItemV2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.food.fdcId != widget.food.fdcId) {
      print(
        '[DEBUG] didUpdateWidget: fdcId changed from ${oldWidget.food.fdcId} to ${widget.food.fdcId}',
      );
      _updateFavoriteFlag();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final repo = context.read<CompleteFoodRepository>();
        final food = await repo.getCompleteFoodByFdcId(widget.food.fdcId);

        if (food == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('No data')));
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewFoodWithNutrients(food: food),
          ),
        );
      },
      child: CustomContainer(
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
                      widget.food.fdcId.toString(),
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

                      setState(() {
                        _isFavorite = !_isFavorite;
                      });

                      if (_isFavorite) {
                        bloc.add(AddFavoriteFoodFdcId(widget.food.fdcId));
                        print(
                          '[DEBUG] Added to favorites: ${widget.food.fdcId}',
                        );
                      } else {
                        bloc.add(RemoveFavoriteFoodFdcId(widget.food.fdcId));
                        print(
                          '[DEBUG] Removed from favorites: ${widget.food.fdcId}',
                        );
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
      ),
    );
  }
}
