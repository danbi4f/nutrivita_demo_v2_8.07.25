import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/foundation_foods/ingredient/data/model/en/final_food_en.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/foundation_foods/ingredient/domain/entities/food_entity.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/foundation_foods/ingredient/presentation/bloc_en/foods_bloc_en.dart';
import 'package:nutrivita_demo_v2/pages/a_categories_page/foundation_foods/ingredient/presentation/bloc_en/foods_state_en.dart';

class IngredientByCategoryEn extends StatelessWidget {
  const IngredientByCategoryEn({super.key, required this.item});

  final FoodEntity item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodsBlocEN, FoodsStateEN>(
      builder: (context, state) {
        final List<FinalFoodEN> foodsEN = state.foods;
        final FinalFoodEN itemEN = foodsEN.firstWhere(
          (e) => item.fdcId == e.fdcId,
          orElse:
              () =>
                  FinalFoodEN(description: 'null', foodNutrients: [], fdcId: 0),
        );
        return SelectableText(
          itemEN.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.surfaceBright,
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}
