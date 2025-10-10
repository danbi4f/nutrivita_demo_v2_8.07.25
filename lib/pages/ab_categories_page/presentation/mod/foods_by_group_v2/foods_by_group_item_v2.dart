import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/common/mod/custom_container.dart';
import 'package:nutrivita_demo_v2/common/mod/view_food_with_nutrients.dart';
import 'package:nutrivita_demo_v2/common/theme/app_text_style.dart';
import 'package:nutrivita_demo_v2/pages/cb_favorite_foods/bloc/favorite_foods_v2_bloc.dart';
import 'package:nutrivita_demo_v2/shared/models/delayed_result.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/domain/model/survey_foods_by_category/mod/top_food.dart';
import 'package:nutrivita_demo_v2/pages/ab_categories_page/data/repository/complete_foods_repository.dart';

class FoodsByGroupItemV2 extends StatefulWidget {
  const FoodsByGroupItemV2({
    super.key,
    required this.topFoodsByGroup,
    required this.unit,
  });

  final TopFood topFoodsByGroup;
  final String unit;

  @override
  State<FoodsByGroupItemV2> createState() => _FoodsByGroupItemV2State();
}

class _FoodsByGroupItemV2State extends State<FoodsByGroupItemV2> {
  bool _isFavorite = false;
  // bool _navigated = false;

  @override
  void initState() {
    super.initState();
    final favoritesState = context.read<FavoriteFoodsV2Bloc>().state.favorites;
    final favoritesList = favoritesState.valueOrNull ?? [];
    _isFavorite = favoritesList.any(
      (food) => food.fdcId == widget.topFoodsByGroup.fdcId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
    // BlocListener<SurveyFoodsByCategoryBloc, SurveyFoodsByCategoryState>(
    //   listenWhen: (previous, current) {
    //     final prevFood = previous.completeFood.valueOrNull;
    //     final currFood = current.completeFood.valueOrNull;
    //     return prevFood?.fdcId != currFood?.fdcId;
    //   },
    //   listener: (context, state) {
    //     if (state.completeFood.isSuccessful && !_navigated) {
    //       print("BlocListener fired: ${state.completeFood}");
    //       _navigated = true;
    //       final food = state.completeFood.value!;
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => ViewFoodWithNutrients(food: food),
    //         ),
    //       );
    //     } else if (state.completeFood.isError) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(state.completeFood.error.toString())),
    //       );
    //     }
    //   },
    //   child:
    InkWell(
      onTap: () async {
        final repo = context.read<CompleteFoodRepository>();
        final food = await repo.getCompleteFoodByFdcId(
          widget.topFoodsByGroup.fdcId,
        );

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
      // onTap: () {
      //   context.read<SurveyFoodsByCategoryBloc>().add(
      //     LoadCompleteFoodByFdcId(widget.topFoodsByGroup.fdcId),
      //   );
      // },
      child: CustomContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.ads_click_rounded, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.topFoodsByGroup.descriptionPL,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subheading(context),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.topFoodsByGroup.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          final bloc = context.read<FavoriteFoodsV2Bloc>();
                          setState(() => _isFavorite = !_isFavorite);
                          if (_isFavorite) {
                            bloc.add(
                              AddFavoriteFoodFdcId(
                                widget.topFoodsByGroup.fdcId,
                              ),
                            );
                          } else {
                            bloc.add(
                              RemoveFavoriteFoodFdcId(
                                widget.topFoodsByGroup.fdcId,
                              ),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[300],
                    child: Text(
                      "${widget.topFoodsByGroup.indexRanking}",
                      style: AppTextStyles.body(context, isBold: true),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.topFoodsByGroup.rankingName}    '
                    '${widget.topFoodsByGroup.nutrientValue.toStringAsFixed(2)} '
                    '${widget.unit}',
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
